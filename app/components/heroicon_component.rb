class HeroiconComponent < ViewComponent::Base
  attr_reader :icon_name

  def initialize(icon_name)
    @icon_name = icon_name
  end

  def call
    find_icon_path.read.html_safe # rubocop:disable Rails/OutputSafety
  end

  private

  def find_icon_path
    Rails.root.join('app/assets/images/heroicons/', icon_name.to_s).sub_ext('.svg')
  end
end
