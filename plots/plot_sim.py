import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.ticker import MultipleLocator, NullLocator
from matplotlib import rcParams

rcParams["font.size"] = 18
rcParams["font.family"] = "Lato"


def read_sim_data(path="data/sim.csv"):
    global distance, secret_key_rate
    sim_data = pd.read_csv(path)
    distance = sim_data["Distance"]
    secret_key_rate = sim_data["Secret key rate"]
    del sim_data


def plot_sim(ax):
    global distance, secret_key_rate
    ax.plot(distance, secret_key_rate, c="#0077bb", lw=2.5)
    ax.set_yscale("log")
    ax.set_xlim(0, 250)
    ax.set_ylim(1e-9, 1e-1)
    ax.margins(x=0)


def plot_experimental_result(ax):
    global result
    ax.scatter(*result, marker="D", c="#009988", s=150, zorder=10)
    lines_kwargs = {"lw": 0.5, "color": "gray"}
    ax.hlines(result[1], *ax.get_xlim(), **lines_kwargs)
    ax.vlines(result[0], *ax.get_ylim(), **lines_kwargs)


def create_params_box(ax):
    ins_ax = ax.inset_axes([10, 10 ** (-8.1), 45, 10 ** (-3)], transform=ax.transData)
    ins_ax.set_xticks([])
    ins_ax.set_yticks([])
    text_lines = [
        r"$\eta_\text{det} = 90\%$",
        r"$\eta_\text{rec} = 40\%$",
        r"$p_\text{dark} = 70~\text{Hz}$",
        r"$p_\text{stray} = 400~\text{Hz}$",
        r"$e_\text{opt} = 2.5\%$",
        r"$\alpha = 0.17~\text{dB/km}$",
        r"$\mu = 0.6$",
        r"$f_\text{clock} = 1~\text{GHz}$",
    ]
    for i, line in enumerate(text_lines):
        ins_ax.text(
            0.5, 0.1 * (9 - 1.2 * i), line, size=15, horizontalalignment="center"
        )


def format_axes(ax):
    ax.xaxis.set_minor_locator(MultipleLocator(10))
    ax.yaxis.set_minor_locator(NullLocator())
    ax.set_yticks([10**-i for i in range(1, 10, 2)])
    ax.set_yticks([10**-i for i in range(2, 9, 2)], minor=True, labels=[])
    ax.set_xlabel("Alice—Bob distance (km)")
    ax.set_ylabel("secret key rate (bit/clock)")


result = (224, 2.9275e-6)

fig, ax = plt.subplots()
fig.set_size_inches(14.4, 4.8)

read_sim_data()
plot_sim(ax)
plot_experimental_result(ax)
create_params_box(ax)
format_axes(ax)

plt.savefig("sim.png", dpi=600, bbox_inches="tight")
