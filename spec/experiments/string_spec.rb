require "spec_helper"

# Stringクラスのテスト(文字列で指定することも可能)
describe String do
    # インスタンスメソッド<<のテスト(慣用的に#をつけるとインスタンスメソッドを表す)
    describe "#<<" do
      example "文字の追加" do
        # pendingを使うと保留中のテストとしてマークできて、失敗してもfailuresには含まれない
        # 実行はされて、もしテストが通るのならば、failureとして扱われる
        # pending("保留中のテスト")

        # 単にスキップしたいときはexampleをexampleメソッドに変えてしまう。pendingと違って保留理由のメッセージは表示されない

        # given
        s = "ABC"
        # when
        s << "D"
        # then
        expect(s.size).to eq(4)
      end
      example "nilの追加はできない", :exception do
        # given
        s = "ABC"
        # when then
        # expectには、ブロックを渡すこともできる
        expect { s << nil }.to raise_error(TypeError)
      end
    end
end