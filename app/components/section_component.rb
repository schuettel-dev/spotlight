class SectionComponent < ViewComponent::Base
  renders_one :body, "SectionBodyComponent"

  def initialize(name:)
    @name = name
  end


  def title
    t("sections.#{@name}")
  end

  def section_class
    "section-#{@name.to_s.parameterize}"
  end

  class SectionBodyComponent < ViewComponent::Base
    def initialize(classes: 'mt-8')
      @classes = classes
    end

    def call
      tag.div(class: @classes) { content }
    end
  end
end
