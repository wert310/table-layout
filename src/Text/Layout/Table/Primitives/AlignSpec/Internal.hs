module Text.Layout.Table.Primitives.AlignSpec.Internal
    ( AlignSpec(..)
    , noAlign
    , occSpecAlign
    , predAlign
    , charAlign
    ) where

import Data.Default.Class

import Text.Layout.Table.Primitives.Occurence

-- | Determines whether a column will align at a specific letter.
data AlignSpec
    = AlignOcc OccSpec
    | NoAlign

-- | No alignment is the default.
instance Default AlignSpec where
    def = noAlign

-- | Don't align text.
noAlign :: AlignSpec
noAlign = NoAlign

-- | Construct an 'AlignSpec' by giving an occurence specification.
occSpecAlign :: OccSpec -> AlignSpec
occSpecAlign = AlignOcc

-- | Align at the first match of a predicate.
predAlign :: (Char -> Bool) -> AlignSpec
predAlign = occSpecAlign . predOccSpec

-- | Align text at the first occurence of a given 'Char'.
charAlign :: Char -> AlignSpec
charAlign = predAlign . (==)
