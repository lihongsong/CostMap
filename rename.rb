# encoding: UTF-8
#!/usr/bin/ruby
require 'fileutils'
require 'active_support/all'

OLD_PREFIX = "Yoser"
NEW_PREFIX = "Yos"

FOLDER_EXCLUDE = ["Pods", ".framework"]
CONTENT_EXCLUDE = [".xcuserstate", ".a", ".mp3", ".avi", ".mp4", ".wmv", ".webp", ".png", ".jpg", ".rb"]

# REGEXP = "([^a-zA-Z_0-9]|^)#{OLD_PREFIX}([A-Z].*?)"
REGEXP = "#{OLD_PREFIX}(.*?)"
NEW_STRING = '\1'+NEW_PREFIX+'\2'

def search(dir)
    Dir[File.join(dir, '*')].each do |file|
        unless FOLDER_EXCLUDE.include?(File.extname(file).empty? ? File.basename(file) : File.extname(file))
            # 非排除的文件夹，才进入搜索
            if File.directory?(file)
                search(file)
            end
        end
        
        if File.file?(file)
            search_content(file)
        end
        filename = File.basename(file)
        new_filename = filename.gsub(Regexp.new(REGEXP), NEW_STRING)
        if filename != new_filename
            dirname = File.dirname(file)
            new_file = File.join(dirname, new_filename)
            puts "重命名文件: #{file} -> #{new_file}"
            File.rename(file, new_file)
        end
    end
end

def search_content(file)
    # 不对排查的文件进行内容替换
    return if CONTENT_EXCLUDE.include?(File.extname(file))
    encoding = `file -I "#{file}"`.strip.split('charset=').last
    encoding = "utf-8" if encoding.empty?
    puts "分析: #{file} (#{encoding})"
    content = File.open(file, "rb:#{encoding}", &:read)
    reg = Regexp.new(REGEXP.encode(encoding))
    new_content = content.gsub(reg, NEW_STRING.encode(encoding))
    if content != new_content
        File.open(file, "w:UTF-8") do |f| 
            f.write(new_content)
        end
        puts "更新文件内容: #{file}"
    end
end

search(Dir.pwd)
