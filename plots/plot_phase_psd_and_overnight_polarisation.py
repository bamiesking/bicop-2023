import numpy as np
from scipy.ndimage import uniform_filter1d
import matplotlib.pyplot as plt
from matplotlib import dates
import os
import re
from plotting.psd import process_psd
import pandas as pd
import datetime


def prepare_phase_data(path='data/'):
    k1_data = []
    k2_data = []

    i = 0
    for file in os.listdir(path):
        if i == 6:
            break
        if re.match(r'phase-acquisition-\d+\.\d+-(\d)', file) is not None:
            data = np.load(os.path.join(path, file))
            k1_data += list(data[0, :])
            k2_data += list(data[1, :])
            del data
            i += 1

    t = np.arange(len(k1_data))/2_000_000
    data = np.column_stack([k1_data, k2_data])
    del k1_data, k2_data

    noise = np.load(
        os.path.join(
            path,
            'noise-phase-acquisition-1688479829.9327974-0.npy'
        )
    )[0, :]

    def normalise(data):
        filter_data = uniform_filter1d(data, 5)
        min = np.min(filter_data)
        max = np.max(filter_data)
        mid = (min + max)/2
        diff = (max - min)
        return np.arccos((2*(data - mid)/diff).clip(-1, 1))

    signal = np.apply_along_axis(normalise, 0, data)
    return (t, signal, noise)


def prepare_polarisation_data(path='data/'):
    df = pd.read_csv(os.path.join(path, 'long-term-polarisation-drift.csv'))
    timestamps = [
        datetime.datetime.strptime(
            ts,
            '%Y-%m-%d %H:%M:%S.%f'
        ) + datetime.timedelta(hours=-1) for ts in df['timestamps'].to_numpy()
    ]
    k1_data = df['k1_data'].to_numpy()
    k2_data = df['k2_data'].to_numpy()
    sensitivity_factor = (
        np.max(k1_data) - np.min(k1_data)
    ) / (
        np.max(k2_data) - np.min(k2_data)
    )
    k1_data /= sensitivity_factor
    k2_data -= np.min(k1_data)
    k1_data -= np.min(k1_data)
    max = np.max(k2_data)

    return (
        timestamps,
        k1_data/max,
        k2_data/max
    )


# Set up figure and axes
fig, (ax0, ax1) = plt.subplots(1, 2)
fig.set_size_inches(14.4, 4.8)
plt.subplots_adjust(hspace=0.35)


def plot_phase_psd(ax):
    # Plot phase PSDs of signal and noise
    global phase_data
    t, signal, noise = phase_data
    f, Pxx = process_psd(t, signal[:, 0])
    ax.loglog(f, Pxx, c='#0077bb', label='phase drift')
    f_noise, Pxx_noise = process_psd(t, noise)
    Pxx_noise *= Pxx[-100]/Pxx_noise[-100]
    ax.loglog(f_noise, Pxx_noise, c='#ee7733', label='detector noise')
    ax.set_xlabel(r'frequency $(\text{Hz})$')
    ax.set_ylabel(r'phase noise PSD $(\text{rad}^2/\text{Hz})$')
    ax.set_xticks([1e0, 1e1, 1e2, 1e3, 1e4, 1e5, 1e6])
    ax.set_xlim(1e0, 1e6)
    ax.set_yticks([1e-11, 1e-9, 1e-7, 1e-5, 1e-3, 1e-1])
    ax.legend()
    ax.text(10**0.05, 10**-1.25, 'a', weight='bold')


def plot_long_term_polarisation(ax):
    global polarisation_data
    timestamps, k1_data, k2_data = polarisation_data
    ax.plot(timestamps, k1_data, label='horizontal', c='#0077bb')
    ax.plot(timestamps, k2_data, label='vertical', c='#009988')
    ax.set_xlabel(r'time')
    ax.set_ylabel('normalised intensity')
    ax.xaxis.set_major_formatter(dates.DateFormatter('%H:%M'))
    ax.legend(loc='center right')
    ax.set_xticks(
        [
            datetime.datetime.strptime(
                '2023-07-05 20:00',
                '%Y-%m-%d %H:%M'
            ) +
            datetime.timedelta(hours=2*i) for i in range(7)
        ]
    )
    ax.margins(x=0)
    ax.text(
        datetime.datetime.strptime(
            '2023-07-05 19:42',
            '%Y-%m-%d %H:%M'
        ),
        1.01,
        'b',
        weight='bold'
    )


phase_data = prepare_phase_data()
plot_phase_psd(ax0)

polarisation_data = prepare_polarisation_data()
plot_long_term_polarisation(ax1)


# Save figure to file
plt.savefig('psd.png', dpi=600, bbox_inches='tight')
# plt.show()
