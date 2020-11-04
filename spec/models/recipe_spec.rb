require 'rails_helper'

describe Recipe do
  describe '#tags_list' do
    let(:recipe) { Recipe.new }
    let(:tags) do
      [
        Tag.new(name: 'tag1'),
        Tag.new(name: 'tag2'),
      ]
    end

    before { recipe.tags = tags }

    it { expect(recipe.tags_list).to eq(%w[tag1 tag2]) }

    context 'tags is nil' do
      let(:tags) { nil }

      it { expect(recipe.tags_list).to eq([]) }
    end
  end
end
