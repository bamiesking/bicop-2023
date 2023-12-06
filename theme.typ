// Adapted from Dr. Rahul Raoniar's modified form of https://github.com/anishathalye/gemini

#let primary = rgb(0, 30, 130)
#let secondary = rgb(230, 235, 240)

#let author(name, affiliation, bold: false) = {
  if (bold) {
    strong[#name]
  } else {
   name 
  }
  " "
  if type(affiliation) == int {
    super[#affiliation]
  } else if type(affiliation) == array {
    for (i, a) in affiliation.enumerate() {
      super[#a]
      if i + 1 < affiliation.len() {
        super[,]
      }
    }
  }
}

#let conf() = {
  set text(font: "Raleway", size: 18pt)
}