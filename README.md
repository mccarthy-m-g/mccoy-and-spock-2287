# Wearing a red uniform shortens lifespan in Starfleet officers

<!-- badges: start -->
[![Render Rmarkdown files](https://github.com/mccarthy-m-g/mccoy-and-spock-2287/workflows/Render%20Rmarkdown%20files/badge.svg)](https://github.com/mccarthy-m-g/mccoy-and-spock-2287/actions?workflow=Render+Rmarkdown+files)

[![Synced with](https://img.shields.io/badge/Synced%20with-OSF-blue.svg)](https://osf.io/9rshp/)
<!-- badges: end -->

*Damn it, man, I'm a doctor, not an undertaker!*

## Project overview

This repository contains a fake scientific paper, written by Bones and Spock from the television series *Star Trek: The Original Series*, made for showcasing how to write a reproducible manuscript in R Markdown. I created it for a workshop as a follow-up to my talk [Doing reproducible science: An opinionated introduction](https://michaelmccarthy.netlify.app/talk/osssg-2021a/).

The project incorporates a number of principles crucial to reproducible science, including:

-   R package environment control using {renv}
-   Version control using GitHub
-   Continuous integration using GitHub Actions
-   Time stamped project snapshots using GitHub Releases
-   Easy access for non-technical users using Open Science Framework integration

Additionally, the project uses [GitHub Pages](https://pages.github.com/) to deploy the knitted R Markdown manuscripts to their own webpages.

## Reproducible manuscript files

The `mccoy-and-spock-2287-distill.Rmd` file includes a complete example of a reproducible manuscript, along with detailed explanations of important concepts for writing and coding in R Markdown documents. The knitted manuscript can be viewed [here](https://mccarthy-m-g.github.io/mccoy-and-spock-2287/mccoy-and-spock-2287-distill.html).

The `mccoy-and-spock-2287-pilot.Rmd` file contains a shorter example intended for introducing beginners to some of the central concepts of R Markdown, such as inline R code, embedding figues, and using bibtex citations. The knitted manuscript can be viewed [here](https://mccarthy-m-g.github.io/mccoy-and-spock-2287/mccoy-and-spock-2287-pilot.html).

The `mccoy-and-spock-2287-papaja.Rmd` file contains the same content as `mccoy-and-spock-2287-distill.Rmd`; it is simply intended to demonstrate `papaja's` APA style output. The knitted manuscript can be viewed [here](https://mccarthy-m-g.github.io/mccoy-and-spock-2287/mccoy-and-spock-2287-papaja.html).
