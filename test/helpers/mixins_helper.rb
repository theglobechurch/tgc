Dir[Rails.root + "app/**/*.rb"].each do |fn|
  require fn
end

class ActiveSupport::TestCase
  def self.classes_that_include(mod)
    ObjectSpace.each_object(Class).select do |cls|
      cls.included_modules.include?(mod)
    end
  end

  def self.test_case_per_class_that_includes(mod, parent = nil, &block)
    test_case_per_class classes_that_include(mod), parent, &block
  end

  # rubocop:disable Style/TrivialAccessors
  def self.test_case_per_class(classes, parent = nil, &block)
    parent ||= ActiveSupport::TestCase
    classes.each do |cls|
      const_set "#{cls.name}#{name}".gsub('::', '_'), Class.new(parent) {
        @cls = cls

        def self.cls
          @cls
        end

        def cls
          self.class.cls
        end

        def cls_singular
          cls.model_name.singular.to_sym
        end

        def create_cls(*args)
          create(cls_singular, *args)
        end

        def build_cls(*args)
          build(cls_singular, *args)
        end

        def self.test_cls(title, &block)
          test "#{cls.name} #{title}", &block
        end

        instance_eval(&block)
      }
    end
  end
end
