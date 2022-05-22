function use_repla_ruby
    set PATH ~/Temp/rake_test/ $PATH
    set PATH /Applications/Repla.app/Contents/Resources/bin $PATH
    set --query GEM_PATH && set --erase GEM_PATH
    set --query GEM_HOME && set --erase GEM_HOME
    set --query RUBY_ROOT && set --erase RUBY_ROOT
end
