# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#


@BindGlobal( "INTEGERS_CAT",
  
 (function ( )
    local category;
    
    #= comment for Julia
    if (IsPackageMarkedForLoading( "LocalesForCAP", ">= 2023.05-05" ))
        
        return ValueGlobal( "TotalOrderAsCategory" )( "IsInt", (a,b) -> a >= b );
        
    else
    # =#
        category = CreateCapCategory( "TotalOrderAsCategory( \"IsInt\" )" );
        category.category_as_first_argument = true;
        
        AddObjectConstructor( category, ( cat, i ) -> CreateCapCategoryObjectWithAttributes( cat, ObjectDatum, i ) );
        AddMorphismConstructor( category, ( cat, s, datum, r ) -> CreateCapCategoryMorphismWithAttributes( cat, s, r ) );
        
        AddPreCompose( category, ( cat, u, v ) -> MorphismConstructor( cat, Source( u ), true, Range( v ) ) );
        AddIdentityMorphism( category, ( cat, u ) -> MorphismConstructor( cat, Source( u ), true, Range( u ) ) );
        
        AddIsWellDefinedForMorphisms( category, ( cat, u ) -> ObjectDatum( Source( u ) ) >= ObjectDatum( Range( u ) ) );
        
        AddIsEqualForObjects( category, ( cat, i, j ) -> IsIdenticalObj( ObjectDatum( i ), ObjectDatum( j ) ) );
        AddIsEqualForMorphisms( category, ( cat, u, v ) -> IsEqualForObjects( Source( u ), Source( u ) ) && IsEqualForObjects( Range( u ), Range( u ) ) );
        
        Finalize( category );
        
        return category;
    #= comment for Julia
    end;
    # =#
    
end)( ) );

@BindGlobal( "INTEGERS_CAT_OBJS",
  
  AsZFunction( i -> ObjectConstructor( INTEGERS_CAT, i ) )
);

@BindGlobal( "INTEGERS_CAT_MORS",
  
  AsZFunction( i -> MorphismConstructor( INTEGERS_CAT, INTEGERS_CAT_OBJS[i+1], true, INTEGERS_CAT_OBJS[i] ) )
);

##
@InstallMethod( ComplexesCategoryByCochains,
        "for a CAP category",
        [ IsCapCategory ],
        
  @FunctionWithNamedArguments(
  [
    [ "overhead", true ],
  ],
  function ( CAP_NAMED_ARGUMENTS, cat )
    local modeling_cat, object_constructor, object_datum, morphism_constructor, morphism_datum, modeling_tower_object_constructor, modeling_tower_object_datum,
      modeling_tower_morphism_constructor, modeling_tower_morphism_datum, coch_cat, category_filter, category_object_filter, category_morphism_filter;
    
    ## building the categorical tower
    
    modeling_cat = PreSheavesWithBounds( INTEGERS_CAT, cat, "both"; overhead = false );
    
    ##
    object_constructor = ( coch_cat, datum ) -> CreateCapCategoryObjectWithAttributes( coch_cat,
                                                            Objects, datum[1],
                                                            Differentials, datum[2],
                                                            LowerBound, datum[3],
                                                            UpperBound, datum[4] );

    
    ##
    object_datum = ( coch_cat, o ) -> @NTupleGAP( 4, Objects( o ), Differentials( o ), LowerBound( o ), UpperBound( o ) );
    
    ##
    morphism_constructor =
      function ( coch_cat, S, datum, R )
        return CreateCapCategoryMorphismWithAttributes( coch_cat, S, R, Morphisms, datum );
    end;
    
    ##
    morphism_datum =
      function( coch_cat, m )
        return Morphisms( m );
    end;
    
    ## from the raw object data to the object in the highest stage of the tower
    modeling_tower_object_constructor =
      function( coch_cat, datum )
        local modeling_cat, presh_cat, presheaf_on_objects, presheaf_on_morphisms, presheaf;
        
        modeling_cat = ModelingCategory( coch_cat );
        presh_cat = AmbientCategory( modeling_cat );
        
        presheaf_on_objects = i -> datum[1][ObjectDatum( i )];
        presheaf_on_morphisms = (s, i, r) -> datum[2][ObjectDatum( Range( i ) )];
        
        presheaf = ObjectConstructor( presh_cat, PairGAP( presheaf_on_objects, presheaf_on_morphisms ) );
        
        return ObjectConstructor( modeling_cat, PairGAP( presheaf, PairGAP( datum[3], datum[4] ) ) );
        
    end;
    
    ## from the object in the highest stage of the tower to the raw object datum
    modeling_tower_object_datum =
      function( coch_cat, obj )
        local presheaf, objs, mors;
        
        presheaf = ObjectDatum( obj )[1];
        
        objs = AsZFunction( i -> PairOfFunctionsOfPreSheaf( presheaf )[1]( INTEGERS_CAT_OBJS[i] ) );
        mors = AsZFunction( i -> PairOfFunctionsOfPreSheaf( presheaf )[2]( objs[i], INTEGERS_CAT_MORS[i], objs[i+1] ) );
        
        return @NTupleGAP( 4, objs, mors, ObjectDatum( obj )[2][1], ObjectDatum( obj )[2][2] );
        
    end;
    
    ## from the raw morphism datum to the morphism in the highest stage of the tower
    modeling_tower_morphism_constructor =
      function( coch_cat, source, datum, range )
        local modeling_cat, presh_cat, nat_trans_on_objs, presheaf_morphism;
        
        modeling_cat = ModelingCategory( coch_cat );
        presh_cat = AmbientCategory( modeling_cat );
        
        nat_trans_on_objs = (s, i, r) -> datum[ObjectDatum( i )];
        presheaf_morphism = MorphismConstructor( presh_cat, ObjectDatum( source )[1], nat_trans_on_objs, ObjectDatum( range )[1] );
        
        return MorphismConstructor( modeling_cat, source, presheaf_morphism, range );
        
    end;
    
    ## from the morphism in the highest stage of the tower to the raw morphism datum
    modeling_tower_morphism_datum =
      function( ch_cat, mor )
        
        return AsZFunction(
                  function ( i )
                    local presheaf_mor;
                    
                    i = INTEGERS_CAT_OBJS[i];
                    presheaf_mor = MorphismDatum( mor );
                    
                    return FunctionOfPreSheafMorphism( presheaf_mor )(
                                PairOfFunctionsOfPreSheaf( Source( presheaf_mor ) )[1]( i ),
                                i,
                                PairOfFunctionsOfPreSheaf( Target( presheaf_mor ) )[1]( i ) );
                    
                  end );
        
    end;
    
    ##
    coch_cat =
      ReinterpretationOfCategory( modeling_cat,
              @rec( name = @Concatenation( "Complexes category by cochains( ", Name( cat ), " )" ),
                   category_filter = IsComplexesCategoryByCochains,
                   category_object_filter = IsCochainComplex,
                   category_morphism_filter = IsCochainMorphism,
                   object_constructor = object_constructor,
                   object_datum = object_datum,
                   morphism_datum = morphism_datum,
                   morphism_constructor = morphism_constructor,
                   modeling_tower_object_constructor = modeling_tower_object_constructor,
                   modeling_tower_object_datum = modeling_tower_object_datum,
                   modeling_tower_morphism_constructor = modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum = modeling_tower_morphism_datum,
                   only_primitive_operations = true ); FinalizeCategory = false, overhead = overhead );
    
    coch_cat.is_computable = true;
    
    SetUnderlyingCategory( coch_cat, cat );
    
    ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_HOMOMORPHISM_STRUCTURE_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY( coch_cat );
    
    Finalize( coch_cat );
    
    return coch_cat;
    
end ) );



##
@InstallGlobalFunction( ADD_FUNCTIONS_OF_LINEARITY_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    
    if (HasIsLinearCategoryOverCommutativeRing( ch_cat ))
        
        AddMultiplyWithElementOfCommutativeSemiringForMorphisms( ch_cat,
          function( ch_cat, r, phi )
            local cat;
            
            cat = UnderlyingCategory( ch_cat );
             
            return CreateComplexMorphism(
                        ch_cat,
                        Source( phi ),
                        ApplyMap( Morphisms( phi ), m -> MultiplyWithElementOfCommutativeSemiringForMorphisms( cat, r, m ) ),
                        Range( phi ) );
        
        end );
    
    end;
    
end );

@InstallGlobalFunction( ADD_FUNCTIONS_OF_EQUALITIES_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    AddIsEqualForObjects( ch_cat,
      function ( ch_cat, B, C )
        local cat, lC, uC;
        
        cat = UnderlyingCategory( ch_cat );
        
        if (IsIdenticalObj( B, C ))
          return true;
        end;
        
        lC = Minimum( LowerBound( B ), LowerBound( C ) );
        uC = Maximum( UpperBound( B ), UpperBound( C ) );
        
        return ForAll( (lC):(uC), i -> IsEqualForObjects( cat, B[i], C[i] ) ) &&
                  ForAll( (lC):(uC), i -> IsEqualForMorphisms( cat, B^i, C^i ) );
        
    end );
    
    AddIsEqualForMorphisms( ch_cat,
      function ( ch_cat, phi, psi )
        local cat, l, u;
        
        cat = UnderlyingCategory( ch_cat );
        
        if (IsIdenticalObj( phi, psi ))
          return true;
        end;
        
        l = Minimum( LowerBound( phi ), LowerBound( psi ) );
        u = Maximum( UpperBound( phi ), UpperBound( psi ) );
        
        return IsEqualForObjects( ch_cat, Source( phi ), Source( psi ) ) &&
                  IsEqualForObjects( ch_cat, Range( phi ), Range( phi ) ) &&
                      ForAll( (l):(u), i -> IsEqualForMorphisms( cat, phi[i], psi[i] ) );
        
    end );
    
    AddIsCongruentForMorphisms( ch_cat,
      function ( ch_cat, phi, psi )
        local cat, l, u;
        
        cat = UnderlyingCategory( ch_cat );
        
        if (IsIdenticalObj( phi, psi ))
          return true;
        end;
        
        l = Minimum( LowerBound( phi ), LowerBound( psi ) );
        u = Maximum( UpperBound( phi ), UpperBound( psi ) );
        
        return IsEqualForObjects( ch_cat, Source( phi ), Source( psi ) ) &&
                  IsEqualForObjects( ch_cat, Range( phi ), Range( phi ) ) &&
                      ForAll( (l):(u), i -> IsCongruentForMorphisms( cat, phi[i], psi[i] ) );
        
    end );

end );
##
@InstallGlobalFunction( ADD_FUNCTIONS_OF_WELL_DEFINEDNESS_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    
    AddIsWellDefinedForObjects( ch_cat,
      function( ch_cat, C )
        
        return ForAll( (LowerBound( C )):(UpperBound( C )), i -> IsWellDefined( C[i] ) &&
                  IsWellDefined( C^i ) &&
                    IsZeroForMorphisms( PreCompose( C^i, C^(i+1) ) ) );
        
    end );
    
    AddIsWellDefinedForMorphisms( ch_cat,
      function( ch_cat, phi )
        local B, C;
        
        B = Source( phi );
        C = Range( phi );
        
        return IsWellDefinedForObjects( ch_cat, B ) &&
                  IsWellDefinedForObjects( ch_cat, C ) &&
                      ForAll( (LowerBound( phi )):(UpperBound( phi )), i -> IsCongruentForMorphisms( PreCompose( B^i, phi[ i + 1 ] ), PreCompose( phi[ i ], C^i ) ) );
    end );
    
end );

##
@InstallGlobalFunction( ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_COCHAIN_COMPLEX_CATEGORY,
  function( ch_cat )
    local range_cat;
    
    if (CanCompute( UnderlyingCategory( ch_cat ), "RandomMorphismWithFixedSourceByList" ))
      
      ##
      AddRandomObjectByList( ch_cat,
        
        function ( ch_cat, L )
          local cat, diffs, u, i, pi;
          
          if (Length( L ) != 3 || !(ForAll( L[ [1,2] ], IsInt )) || @not IsList( L[3] ))
              Error("the input should be a list consisting of two integers and a list!\n");
          end;
          
          cat = UnderlyingCategory( ch_cat );
          
          if (L[1] > L[2])
            
            return ZeroObject( ch_cat );
            
          else
            
            diffs = [ RandomMorphismWithFixedSourceByList( cat, ZeroObject( cat ) , L[3] ) ];
            
            u = L[2] - L[1] + 1;

            for i in (2):(u)
              
              pi = ValueGlobal( "WeakCokernelProjection" )( cat, diffs[i-1] );
              
              Add( diffs, PreCompose( cat, pi, RandomMorphismWithFixedSourceByList( cat, Range( pi ), L[3] ) ) );
              
            end;
            
            return CreateComplex( ch_cat, diffs, L[1] );
            
          end;
          
      end );
    
    end;
    
    if (CanCompute( UnderlyingCategory( ch_cat ), "RandomMorphismWithFixedSourceByInteger" ))
      
      ##
      AddRandomObjectByInteger( ch_cat,
        
        function ( ch_cat, n )
          local cat, diffs, i, pi;
          
          if (IsNegInt( n ))
            Error("the integer passed to 'RandomObjectByInteger' in ", Name( ch_cat ), " should be a non-negative integer!\n" );
          end;
          
          cat = UnderlyingCategory( ch_cat );
          
          if (n == 0)
            
            return ZeroObject( ch_cat );
            
          else
            
            diffs = [ RandomMorphismByInteger( cat, 1 + Log2Int( n ) ) ];
            
            for i in (2):(n)
              
              pi =  ValueGlobal( "WeakCokernelProjection" )( cat, diffs[i-1] );
              
              Add( diffs, PreCompose( cat, pi, RandomMorphismWithFixedSourceByInteger( cat, Range( pi ), 1 + Log2Int( n ) ) ) );
              
            end;
            
            return CreateComplex( ch_cat, diffs, -IntGAP( n/2 ) );
            
          end;
          
      end );
    
    end;
    
    if (HasRangeCategoryOfHomomorphismStructure( ch_cat ))
      
      range_cat = RangeCategoryOfHomomorphismStructure( ch_cat );
      
      if (CanCompute( range_cat, "RandomMorphismWithFixedSourceAndRangeByList" ))
        
        ##
        AddRandomMorphismWithFixedSourceAndRangeByList( ch_cat,
          
          function ( ch_cat, S, R, L )
            local range_cat, hom_SR, distinguished_object, ell;
            
            range_cat = RangeCategoryOfHomomorphismStructure( ch_cat );
            
            hom_SR = HomomorphismStructureOnObjects( ch_cat, S, R );
            
            distinguished_object = DistinguishedObjectOfHomomorphismStructure( ch_cat );
            
            ell = RandomMorphismWithFixedSourceAndRangeByList( range_cat, distinguished_object, hom_SR, L );
            
            return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ch_cat, S, R, ell );
            
        end );
        
      end;
      
      if (CanCompute( range_cat, "RandomMorphismWithFixedSourceAndRangeByInteger" ))
      
        ##
        AddRandomMorphismWithFixedSourceAndRangeByInteger( ch_cat,
          
          function ( ch_cat, S, R, n )
            local range_cat, hom_SR, distinguished_object, ell;
            
            range_cat = RangeCategoryOfHomomorphismStructure( ch_cat );
            
            hom_SR = HomomorphismStructureOnObjects( ch_cat, S, R );
            
            distinguished_object = DistinguishedObjectOfHomomorphismStructure( ch_cat );
            
            ell = RandomMorphismWithFixedSourceAndRangeByInteger( range_cat, distinguished_object, hom_SR, n );
            
            return InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( ch_cat, S, R, ell );
            
        end );
        
      end;
      
    end;
    
end );

##
@InstallMethod( ComplexesCategoryByChains,
        "for a CAP category",
        [ IsCapCategory ],
        
  @FunctionWithNamedArguments(
  [
    [ "overhead", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, cat )
    local object_constructor, object_datum, morphism_constructor, morphism_datum, coch_cat, modeling_tower_object_constructor, modeling_tower_object_datum, modeling_tower_morphism_constructor, modeling_tower_morphism_datum, ch_cat, category_filter, category_object_filter, category_morphism_filter, only_primitive_operations;
    
    ##
    object_constructor = ( ch_cat, datum ) -> CreateCapCategoryObjectWithAttributes( ch_cat,
                                                            Objects, datum[1],
                                                            Differentials, datum[2],
                                                            LowerBound, datum[3],
                                                            UpperBound, datum[4] );

    
    ##
    object_datum = ( ch_cat, o ) -> @NTupleGAP( 4, Objects( o ), Differentials( o ), LowerBound( o ), UpperBound( o ) );
    
    ##
    morphism_constructor = ( ch_cat, S, datum, R ) -> CreateCapCategoryMorphismWithAttributes( ch_cat,
                                                            S, R,
                                                            Morphisms, datum );
    
    ##
    morphism_datum = ( ch_cat, m ) -> Morphisms( m );
    
    ## building the categorical tower
    
    coch_cat = ComplexesCategoryByCochains( cat; overhead = overhead );
    
    ## from the raw object data to the object in the highest stage of the tower
    modeling_tower_object_constructor =
      function( ch_cat, datum )
        local coch_cat;
        
        coch_cat = ModelingCategory( ch_cat );
        
        return CreateComplex( coch_cat, Reflection( datum[1] ), Reflection( datum[2] ), -datum[4], -datum[3] );
        
    end;
    
    ## from the object in the highest stage of the tower to the raw object datum
    modeling_tower_object_datum =
      function( ch_cat, obj )
        
        return [ Reflection( Objects( obj ) ), Reflection( Differentials( obj ) ), -UpperBound( obj ), -LowerBound( obj ) ];
        
    end;
    
    ## from the raw morphism datum to the morphism in the highest stage of the tower
    modeling_tower_morphism_constructor =
      function( ch_cat, source, datum, range )
        local coch_cat;
        
        coch_cat = ModelingCategory( ch_cat );
        
        return CreateComplexMorphism( coch_cat, source, Reflection( datum ), range );
        
    end;
    
    ## from the morphism in the highest stage of the tower to the raw morphism datum
    modeling_tower_morphism_datum =
      function( ch_cat, mor )
        
        return Reflection( Morphisms( mor ) );
        
    end;
    
    ##
    ch_cat =
      ReinterpretationOfCategory( coch_cat,
              @rec( name = @Concatenation( "Complexes category by chains( ", Name( cat ), " )" ),
                   category_filter = IsComplexesCategoryByChains,
                   category_object_filter = IsChainComplex,
                   category_morphism_filter = IsChainMorphism,
                   object_constructor = object_constructor,
                   object_datum = object_datum,
                   morphism_datum = morphism_datum,
                   morphism_constructor = morphism_constructor,
                   modeling_tower_object_constructor = modeling_tower_object_constructor,
                   modeling_tower_object_datum = modeling_tower_object_datum,
                   modeling_tower_morphism_constructor = modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum = modeling_tower_morphism_datum,
                   only_primitive_operations = true ); FinalizeCategory = false, overhead = overhead );
    
    SetUnderlyingCategory( ch_cat, cat );
     
    ## random methods by lists
    ##
    if (CanCompute( coch_cat, "RandomObjectByList" ))
    
      AddRandomObjectByList( ch_cat,
        
        ( ch_cat, L ) -> ObjectConstructor( ch_cat, modeling_tower_object_datum( ch_cat, RandomObjectByList( ModelingCategory( ch_cat ), [ -L[2], -L[1], L[3] ] ) ) )
      );
    
    end;
    
    if (CanCompute( coch_cat, "RandomMorphismWithFixedSourceAndRangeByList" ))
      
      AddRandomMorphismWithFixedSourceAndRangeByList( ch_cat,
        ( ch_cat, S, R, L ) -> MorphismConstructor(
                                  ch_cat,
                                  S,
                                  modeling_tower_morphism_datum(
                                      ch_cat,
                                      RandomMorphismWithFixedSourceAndRangeByList(
                                          ModelingCategory( ch_cat ),
                                          modeling_tower_object_constructor( ch_cat, ObjectDatum( S ) ),
                                          modeling_tower_object_constructor( ch_cat, ObjectDatum( R ) ),
                                          L ) ),
                                  R ) );
    end;
    ##
    ##########################
    
    Finalize( ch_cat );
    
    return ch_cat;
    
end ) );

