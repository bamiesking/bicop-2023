#import "theme.typ": conf, author, primary, secondary
// #show: doc => conf(title, authors, affiliations )

#set text(font: "Raleway", size: 19pt)
#show figure.caption: set text(font: "Lato", size: 16pt)

#let authors = (
  (
    "name": "Ben Amies-King",
    "affiliations": 1,
  ),
  (
    "name": "Karolina P. Schatz",
    "affiliations": 1,
  ),
  (
    "name": "Haofan Duan",
    "affiliations": 1,
  ),
  (
    "name": "Ayan Biswas",
    "affiliations": 1,
  ),
  (
    "name": "Jack Bailey",
    "affiliations": 2,
  ),
  (
    "name": "Adrian Felvinti",
    "affiliations": 2,
  ),
  (
    "name": "Jaimes Winward",
    "affiliations": 2,
  ),
  (
    "name": "Mike Dixon",
    "affiliations": 2,
  ),
  (
    "name": "Mariella Minder",
    "affiliations": (1, 3),
  ),
  (
    "name": "Rupesh Kumar",
    "affiliations": 1,
  ),
  (
    "name": "Sophie Albosh",
    "affiliations": 1,
  ),
  (
    "name": "Marco Lucamarini",
    "affiliations": 1,
  )
)

#let affiliations = (
  "University of York; York YO10 5FT, UK",
  "euNetworks Fiber UK Limited; London E14 5HU, UK",
  "Cyprus University of Technology; Limassol 3036, Cyprus",
)

#let footer = align(bottom)[
  #block(height: 2cm, fill: primary, inset: (x: 1cm))[
    #set align(horizon)
    #set text(fill: white, size: 21.2pt, font: "Lato", weight: "bold")
    #stack(
      dir: ltr,
      block(width: 33%)[
        #set align(left)
        doi: 10.3390/e25121572
      ],
      block(width: 34%)[
        #set align(center)
        Optica BICOP
      ],
      block(width: 33%)[
        #set align(right)
        13-15th December 2023
      ],
    )]
]

#set page(
  paper: "a1",
  number-align: center,
  margin: (x: 0cm, y: 0cm),
  footer: footer
);

#block(height: 11cm, width: 100%, inset: 4pt, fill: primary, radius: (bottom-left: 2cm), spacing: 0cm, stroke: primary)[ 
  #set block(width: 100%, height: 100%, inset: 4pt);
  #stack(dir: ltr,
    block(width: 2%),
    block(width: 25%)[
      #set align(center + horizon);
      #image("images/UOY_Logo.png", width: 16.6cm);
    ],
    block(width: 5%),
    block(width: 65%)[
      #set align(center + horizon)
      #stack(dir: ttb,
        block(height: 50%)[
          #set text(fill: white, size: 40pt, weight: "bold")
          Feasibility of direct quantum communications between the UK and Ireland via 224~km of underwater fibre
        ],
        block(height: 30%)[
          #stack(dir: ltr,
            block(width: 58%)[
              #set text(fill: white, size: 17pt)
              #for (i, a) in authors.enumerate() {
                box(width: auto, height: auto, inset: 0pt)[
                #author(a.name, a.affiliations, bold: i == 0)
                #if i + 1 < authors.len() {
                  ","
                  h(0.5cm)
                }
              ]
              }

            ],
            block(width: 5%),
            block(width: 50%)[
              #set text(fill: white, size: 17pt)
              #set align(left)
              #for (i, a) in affiliations.enumerate(start: 1) {
                super(str(i))
                h(0.5cm)
                a 
                linebreak()
              }
            ])
        ]
    )
  ])
]

#let heading(title) = {
    text(size: 28pt, fill: primary, weight: "bold")[#title] 
    linebreak()
    line(length: 100%) 
}

#let section(title, content) = {
  block(width: auto, height: auto)[
    #heading(title)
    #set align(left)
    #par(justify: true)[
      #content  
    ]
  ]
}

#block(height: 80%, width: 100%, fill: primary, inset: 0cm, spacing: -1cm, radius: (top-left: 2cm))[
  #block(height: 101%, width: 100%, radius: (top-right: 2cm), fill: white, inset: (y: 2cm), spacing: 0cm, outset: 0cm)[
    #align(center)[
      #block(width: 80%, height: auto, fill: secondary, inset: 1cm)[
        #section("Abstract")[
          #set text(size: 22pt)
          The future of Quantum Key Distribution (QKD) is contingent on its ability to utilise the existing fibre infrastructure that makes up the global Internet. In this work, we explore the feasibility of quantum communications over 224~km of submarine fibre between the UK and Ireland. We characterise differential phase drift, polarisation stability and entangled photon arrival times to demonstrate the suitability of this fibre for several common implementations of QKD. 
        ]
      ]
    ]
    
    #align(center)[
      #block(width: 90%, height: 100%, inset: 1cm)[
        #stack(dir: ltr,
        block(width: 50%)[
          #section("Introduction")[
            Quantum key distribution (QKD) @bennett_quantum_2014 offers information-theoretically secure communications against an any eavesdropper, regardless of their computational capability. QKD is one of the most mature quantum technologies and several protocols have already seen commercial implementations. As the commercial viability of QKD continues to develop, long-haul international connections are increasingly important for demonstrating the feasibility of deployed QKD systems.
    
            We explore the suitability for QKD of euNetworks' 'Rockabill' link, which is a 224~km submarine fibre running between Portrane in the Republic of Ireland and Soutport in the United Kingdom. We consider optical phase, polarisation, and entangled photons to provide a broad view of the feasibility of future deployments of QKD. 
          ]
          #v(1cm)
          #block(width: auto, height: auto, fill: secondary, outset: 0.5cm)[
            #section("Key objectives")[
              #set align(left)
              #list(
                [Characterising phase drift and polarisation stability of long-haul submarine fibre.],
                [Emulating decoy-state BB84 with polarisation encoding.],
                [Detecting coincident photons from an entangled photon source after traversing the channel.]            
              )
            ]
          ] 
          #v(1cm)
          #section("Methods")[ 
            We designed compact and robust rack-mount modules to enable measurement of differential phase drift between a pair of fibres, long-term polarisation drift over the course of 14 hours, and polarisation quantum bit error rate (QBER) measurements for various decoy-state intensities at the single photon level.
            We also deployed a compact, commercial source of entangled photon pairs (OZ Optics Ruby) with the aim of testing the feasibility of entanglement distribution over the link.
            Schematics and detailed descriptions of the experiments are given in @amies-king_quantum_2023.
            #figure(
              image("images/map.png"),
              caption: [
                Subfigures *a* and *b* show the Rockabill link between Portrane, IE and Southport, UK. Subfigures *c*-*e* show the experimental subsystems for differential phase, polarisation, and coincident pair measurements respectively. 
              ]
            )
    
            The high optical loss of a long single-hop submarine link, even one consisting of cutting-edge ultra-low-loss fibre, meant that a high-performance single photon detector was required to enable a launch power at the quantum level.
            To achieve this, we deployed our superconducting nanowire single-photon detector (SNSPD) system (IDQuantique ID281) in the Southport CLS.
            Each SNSPD channel has dark counts of around 50~Hz, with detection efficiency of \~90%.
          ]
          #v(1cm)
        ],
      block(width: 3%),
      block(width: 50%)[
              #section("Results")[
                The results of the experiments showed that the 'Rockabill' link is a suitable link for implementing quantum communications between the mainland UK and Ireland.
                Firstly, low differential phase noise indicates good isolation from the environment, and residual phase characteristics are well within that which can be compensated with existing hardware or software techniques.
    
                #figure(
                  image("plots/psd.png"),
                  caption: [
                    Subplot *a* shows the power spectral density (PSD) of the channel phase drift (blue, upper line) and detector noise (orange, lower line). Subplot *b* shows the horizontal and vertical polarisation components of channel polarisation drift over \~14~h. 
                  ]
                )
                
                Secondly, we observed very good polarisation stability over the course of 14 hours, and extrapolated a positive secret key rate (SKR) from our decoy-state polarisation-encoded BB84 emulation, indicating feasibility for polarisation-based QKD.
                However, our simulation showed us as being at the upper limits of tolerable loss, and so further optimisations may be required for a full QKD deployment.
    
                #figure(
                  image("plots/sim.png"),
                  caption: [
                    Simulated (blue line) and emulated (green diamond) key rates.
                    #let spacing = 0.4em
                    Simulation parameters:
                    detection efficiency
                    #h(spacing, weak: true)
                    $eta_"det"$,
                    #h(spacing, weak: true)
                    efficiency of the receiver
                    #h(spacing, weak: true)
                    $eta _"rec"$,
                    #h(spacing, weak: true)
                    dark counts
                    #h(spacing, weak: true)
                    $p_"dark"$,
                    #h(spacing, weak: true)
                    background photons from the channel
                    #h(spacing, weak: true)
                    $p_"stray"$,
                    #h(spacing, weak: true)
                    optical noise
                    #h(spacing, weak: true)
                    $e_"opt"$,
                    #h(spacing, weak: true)
                    mean photon number
                    #h(spacing, weak: true)
                    $mu$,
                    #h(spacing, weak: true)
                    clock rate of the simulated system
                    #h(spacing, weak: true)
                    $f_"clock"$.
                  ]
                )
                
                As other fibres in the bundle are in active use by commercial entities, a high level of crosstalk-induced noise was present in the channels under test.
                In spite of this, we observed coincident single photon detections between the two channels indicating the arrival of pairs from the entangled photon source, with a coincidence to accidental ratio (CAR) of 1.92.
    
          ] 
          #v(1cm)
          #block(width: auto, height: auto, fill: secondary, outset: 0.5cm)[
            #section("Summary")[
              We demonstrated the promising phase and polarisation stability of the Rockabill link, and emulated the performance of decoy-state BB84 with polarisation encoding in which a positive secret key rate was obtained. Furthermore, we demonstrated coincidence counts from an entangled photon source transmitted over the submarine link. 
            ]
          ]
          #v(1cm)
          #section("References")[
            #set align(left)
            #bibliography("BICOP 2023.bib", title: none)
          ]
      ])
      ]
    ]
  ]
]
