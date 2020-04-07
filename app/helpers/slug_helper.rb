module SlugHelper
  def generate_slug
    self.slug = "#{self.title.parameterize.underscore.slice(0, 15)}_#{generate_random_nums_for_slug}"
  end

  def generate_random_nums_for_slug
    10.times.map { rand(0..9) }.join
  end
end