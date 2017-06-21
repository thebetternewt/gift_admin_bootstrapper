require 'fileutils'

script_directories = %w{ cc-reports bulldogclub pledge_reminders }
git_repos = Hash[
  script_directories.collect do |dir|
    [dir, "https://github.com/thebetternewt/#{dir}.git"]
  end
]

# git_repos.each { |l| puts l } # DEBUG INFO

if /cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM # Check if Windows OS
  Dir.mkdir('\\Ruby Scripts') unless Dir.exist?('\\Ruby Scripts')

  puts "WARNING: Continuing will delete any contents in the following directories"
  puts "not up to date with the respective git repository:"
  script_directories.each { |dir| puts 'C:\Ruby Scripts\\' + dir }
  puts
  print "Press any key to continue, or CTRL-C to exit..."
  STDIN.getc
  sleep(0.2)

  script_directories.select do |directory|
    path = '\\Ruby Scripts\\' + directory
    puts "Searching for: #{path}"
    sleep(0.5)
    if Dir.exist?(path) && Dir.exist?(path + '\.git')
      puts "Found #{directory}!"
      puts "Preparing to update git repository (new window)..."
      sleep(0.5)
      system %{ start cmd /k "cd #{path} && git pull" }
    elsif Dir.exist?(path)
      puts "Found #{directory}!"
      puts "Not a git repository...removing directory and contents..."
      FileUtils.rm_rf(path)
      FileUtils.cd('\Ruby Scripts')
      puts "Preparing to clone new repository (new window)..."
      sleep(0.5)
      system %{ start cmd /k "cd \\Ruby Scripts & git clone #{git_repos[directory]}" }
    else
      puts "Did not find #{directory}!"
      puts "Preparing to clone repository (new window)..."
      sleep(0.5)
      system %{ start cmd /k "cd \\Ruby Scripts & git clone #{git_repos[directory]}" }
    end
  end

else system %{cd /} # Assume Mac OS/Linux
  # Not yet implemented.
  puts "Please install scripts manually. Not yet implemented for *NIX systems."
end




