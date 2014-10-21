class BlankSlate

  instance_methods.each do |name|
    class_eval do
      unless name =~ /^__|^instance_eval$|^binding$|^object_id$|^ai$|/
      # unless name =~ /^__|^instance_eval$|^binding$|^object_id$|/
        undef_method name
      end
    end
  end

end
