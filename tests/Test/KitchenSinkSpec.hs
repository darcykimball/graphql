module Test.KitchenSinkSpec
    ( spec
    ) where

import qualified Data.Text.IO as Text.IO
import qualified Language.GraphQL.Encoder as Encoder
import qualified Language.GraphQL.Parser as Parser
import Paths_graphql (getDataFileName)
import Test.Hspec ( Spec
                  , describe
                  , it
                  )
import Test.Hspec.Expectations ( expectationFailure
                               , shouldBe
                               )
import Text.Megaparsec ( errorBundlePretty
                       , parse
                       )

spec :: Spec
spec = describe "Kitchen Sink" $
    it "prints the query" $ do
        dataFileName <- getDataFileName "tests/data/kitchen-sink.min.graphql"
        expected <- Text.IO.readFile dataFileName

        either
            (expectationFailure . errorBundlePretty)
            (flip shouldBe expected . Encoder.document)
            $ parse Parser.document dataFileName expected
