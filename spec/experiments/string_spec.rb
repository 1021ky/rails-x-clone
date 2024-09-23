require "spec_helper"

describe String do
    describe "#<<" do
      example "文字の追加" do
        # arrange
        s = "ABC"
        # act
        s << "D"
        # assert
        expect(s.size).to eq(4)
      end
    end
end