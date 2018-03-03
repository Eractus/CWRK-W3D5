class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      self.send(:define_method, "#{name}=".to_sym) do |val|
        instance_variable_set("@" + name.to_s, val)
      end
      self.send(:define_method, name.to_sym) do
        instance_variable_get("@" + name.to_s)
      end
    end
  end
end
