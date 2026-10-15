
```jldoctest AutoDocTests
julia> using CAP, Singular, MatricesForHomalg, LinearAlgebraForCAP, QuotientCategories, LinearClosuresForCAP, AdditiveClosuresForCAP, FpCategories, FpLinearCategories, PresheafCategories, ComplexesCategories, TriangulatedCategories, SubcategoriesForCAP, FreydCategoriesForCAP, FiniteCocompletions, FunctorCategories, HomotopyCategories

julia> true
true

julia> true
true

julia> q_O = FinQuiver( "q_O(A,B,C)[x:A->B,y:A->B,z:B->C,w:B->C]" )
FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" )

julia> P_O = PathCategory( q_O )
PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) )

julia> rho_O = [ [ P_O.xz, P_O.yw ] ];

julia> quotient_P_O = QuotientCategory( P_O, rho_O )
PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) ) / [ x⋅z == y⋅w ]

julia> QQ = HomalgFieldOfRationals( )
Rational field

julia> k = QQ
Rational field

julia> k_quotient_P_O = k[quotient_P_O]
Q-LinearClosure( PathCategory( FinQuiver( "q_O(A,B,C)[x:A→B,y:A→B,z:B→C,w:B→C]" ) ) / [ x⋅z == y⋅w ] )

julia> IsAdmissibleAlgebroid( k_quotient_P_O )
true

julia> A_O = AlgebroidFromDataTables( k_quotient_P_O )
Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms

julia> Dimension( A_O )
10

julia> HasIsAdmissibleAlgebroid( A_O ) && IsAdmissibleAlgebroid( A_O )
true

julia> PSh = PreSheavesOfFpEnrichedCategory( A_O )
PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )

julia> Y1 = YonedaEmbeddingOfSourceCategory( PSh )
Yoneda embedding functor

julia> Display( Y1 )
Yoneda embedding functor:

Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms
  |
  V
PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )

julia> ApplyFunctor( Y1, A_O.x )
<(A)->1x2, (B)->0x1, (C)->0x0>

julia> Y2 = ExtendFunctorToAdditiveClosureOfSource( Y1 )
Extension of Yoneda embedding functor to a functor from the additive closure of the source

julia> Display( Y2 )
Extension of Yoneda embedding functor to a functor from the additive closure of the source:

AdditiveClosure( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms )
  |
  V
PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )

julia> add_A_O = SourceOfFunctor( Y2 )
AdditiveClosure( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms )

julia> ApplyFunctor( Y2, A_O.x / add_A_O )
<(A)->1x2, (B)->0x1, (C)->0x0>

julia> Y3 = ExtendFunctorToFreydCategory( Y2 )
Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) )

julia> Display( Y3 )
Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) ):

Freyd( AdditiveClosure( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms ) )
  |
  V
PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) )

julia> Display( SourceOfFunctor( Y3 ) )
A CAP category with name Freyd( AdditiveClosure( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms ) ):

48 primitive operations were used to derive 360 operations for this category which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
* IsAbelianCategoryWithEnoughProjectives

julia> Display( RangeOfFunctor( Y3 ) )
A CAP category with name PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ):

59 primitive operations were used to derive 363 operations for this category which algorithmically
* IsCategoryWithDecidableColifts
* IsCategoryWithDecidableLifts
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
* IsAbelianCategoryWithEnoughInjectives
* IsAbelianCategoryWithEnoughProjectives

julia> Y4 = ExtendFunctorToHomotopyCategoriesByCochains( Y3 )
Extension of ( Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) ) ) to homotopy categories by cochains

julia> Display( Y4 )
Extension of ( Extension to FreydCategory( Source( Extension of Yoneda embedding functor to a functor from the additive closure of the source ) ) ) to homotopy categories by cochains:

Homotopy category by cochains( Freyd( AdditiveClosure( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms ) ) )
  |
  V
Homotopy category by cochains( PreSheaves( Q-algebroid( [A,B,C][x:A→B,y:A→B,z:B→C,w:B→C] ) defined by 3 objects and 4 generating morphisms, Rows( Q ) ) )

julia> f = RandomMorphism( SourceOfFunctor( Y4 ), 3 );

julia> Y4_f = ApplyFunctor( Y4, f );

julia> r1 = RankOfObject( HomomorphismStructureOnObjects( Source( f ), Target( f ) ) );

julia> r2 = RankOfObject( HomomorphismStructureOnObjects( Source( Y4_f ), Target( Y4_f ) ) );

julia> r1 == r2
true

```
