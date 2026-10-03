<!-- BEGIN HEADER -->
# HomotopyCategories

### Homotopy categories of additive categories

| Documentation |
| ------------- |
| [![HTML stable documentation][html-img]][html-url] [![PDF stable documentation][pdf-img]][pdf-url] |

<!-- END HEADER -->

This is the Julia version of the [CAP-based][CAP_based] package [HomotopyCategories][HomotopyCategories].

## Release status

| Package | Release status |
| --- | --- |
| HomotopyCategories | ![HomotopyCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Frelease.json) |

### Required dependencies

Each badge confirms that Julia's General registry has an available release satisfying this package's declared compatibility bound.

| Dependency | Release status |
| --- | --- |
| [AdditiveClosuresForCAP](https://github.com/JuliaRegistries/General/tree/master/A/AdditiveClosuresForCAP) | ![AdditiveClosuresForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FAdditiveClosuresForCAP.json) |
| [CAP](https://github.com/JuliaRegistries/General/tree/master/C/CAP) | ![CAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FCAP.json) |
| [ComplexesCategories](https://github.com/JuliaRegistries/General/tree/master/C/ComplexesCategories) | ![ComplexesCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FComplexesCategories.json) |
| [FiniteCocompletions](https://github.com/JuliaRegistries/General/tree/master/F/FiniteCocompletions) | ![FiniteCocompletions release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FFiniteCocompletions.json) |
| [FpCategories](https://github.com/JuliaRegistries/General/tree/master/F/FpCategories) | ![FpCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FFpCategories.json) |
| [FpLinearCategories](https://github.com/JuliaRegistries/General/tree/master/F/FpLinearCategories) | ![FpLinearCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FFpLinearCategories.json) |
| [FreydCategoriesForCAP](https://github.com/JuliaRegistries/General/tree/master/F/FreydCategoriesForCAP) | ![FreydCategoriesForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FFreydCategoriesForCAP.json) |
| [FunctorCategories](https://github.com/JuliaRegistries/General/tree/master/F/FunctorCategories) | ![FunctorCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FFunctorCategories.json) |
| [LinearAlgebraForCAP](https://github.com/JuliaRegistries/General/tree/master/L/LinearAlgebraForCAP) | ![LinearAlgebraForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FLinearAlgebraForCAP.json) |
| [LinearClosuresForCAP](https://github.com/JuliaRegistries/General/tree/master/L/LinearClosuresForCAP) | ![LinearClosuresForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FLinearClosuresForCAP.json) |
| [MatricesForHomalg](https://github.com/JuliaRegistries/General/tree/master/M/MatricesForHomalg) | ![MatricesForHomalg release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FMatricesForHomalg.json) |
| [PresheafCategories](https://github.com/JuliaRegistries/General/tree/master/P/PresheafCategories) | ![PresheafCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FPresheafCategories.json) |
| [QuotientCategories](https://github.com/JuliaRegistries/General/tree/master/Q/QuotientCategories) | ![QuotientCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FQuotientCategories.json) |
| [SubcategoriesForCAP](https://github.com/JuliaRegistries/General/tree/master/S/SubcategoriesForCAP) | ![SubcategoriesForCAP release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FSubcategoriesForCAP.json) |
| [TriangulatedCategories](https://github.com/JuliaRegistries/General/tree/master/T/TriangulatedCategories) | ![TriangulatedCategories release status](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fhomalg-project%2FReleaseStatusForJuliaPackages%2Fmain%2FHigherHomologicalAlgebra.jl%2FHomotopyCategories%2Fdependencies%2FTriangulatedCategories.json) |

The badge data is refreshed every hour by the [central release-status workflow][ReleaseStatusWorkflow].

[CAP_based]: https://homalg-project.github.io/docs/CAP_project-based/
[HomotopyCategories]: https://homalg-project.github.io/pkg/HomotopyCategories
[ReleaseStatusWorkflow]: https://github.com/homalg-project/ReleaseStatusForJuliaPackages/actions/workflows/update-release-status.yml

<!-- BEGIN FOOTER -->
[html-img]: https://img.shields.io/badge/🔗%20HTML-stable-blue.svg
[html-url]: https://homalg-project.github.io/HigherHomologicalAlgebra/HomotopyCategories/doc/chap0_mj.html

[pdf-img]: https://img.shields.io/badge/🔗%20PDF-stable-blue.svg
[pdf-url]: https://homalg-project.github.io/HigherHomologicalAlgebra/HomotopyCategories/download_pdf.html
<!-- END FOOTER -->
