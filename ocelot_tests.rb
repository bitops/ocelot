#!/usr/bin/env ruby

# Task: Implement the ocelot utility and get these tests to pass on a system 
# which has the UNIX cat command present

# To see Gregory Brown's solution, see http://github.com/elm-city-craftworks/ocelot
# Feel free to publicly share your own solutions

require "open3"

working_dir = File.dirname(__FILE__)
gettysburg_file = "#{working_dir}/data/gettysburg.txt"
spaced_file     = "#{working_dir}/data/spaced_out.txt"

############################################################################

cat_output  = `cat #{gettysburg_file}`
ocelot_output = `ocelot #{gettysburg_file}`

fail "Failed 'cat == ocelot'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat #{gettysburg_file} #{spaced_file}`
ocelot_output = `ocelot #{gettysburg_file} #{spaced_file}`

fail "Failed 'cat [f1 f2] == ocelot [f1 f2]'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat < #{spaced_file}`
ocelot_output = `ocelot < #{spaced_file}`

unless cat_output == ocelot_output
  fail "Failed 'cat < file == ocelot < file" 
end

############################################################################

cat_output  = `cat -n #{gettysburg_file}`
ocelot_output = `ocelot -n #{gettysburg_file}`

fail "Failed 'cat -n == ocelot -n'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat -b #{gettysburg_file}`
ocelot_output = `ocelot -b #{gettysburg_file}`

fail "Failed 'cat -b == ocelot -b'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat -s #{spaced_file}`
ocelot_output = `ocelot -s #{spaced_file}`

fail "Failed 'cat -s == ocelot -s'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat -bs #{spaced_file}`
ocelot_output = `ocelot -bs #{spaced_file}`

fail "Failed 'cat -bns == ocelot -bns'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat -bns #{spaced_file}`
ocelot_output = `ocelot -bns #{spaced_file}`

fail "Failed 'cat -bns == ocelot -bns'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat -nbs #{spaced_file}`
ocelot_output = `ocelot -nbs #{spaced_file}`

fail "Failed 'cat -nbs == ocelot -nbs'" unless cat_output == ocelot_output

############################################################################

cat_output  = `cat -ns #{gettysburg_file} #{spaced_file}`
ocelot_output = `ocelot -ns #{gettysburg_file} #{spaced_file}`

unless cat_output == ocelot_output
  fail "Failed 'cat -ns [f1 f2] == ocelot -ns [f1 f2]'" 
end

############################################################################

cat_output  = `cat -bs #{gettysburg_file} #{spaced_file}`
ocelot_output = `ocelot -bs #{gettysburg_file} #{spaced_file}`

unless cat_output == ocelot_output
  fail "Failed 'cat -bs [f1 f2] == ocelot -bs [f1 f2]'" 
end

############################################################################

`cat #{gettysburg_file}`
cat_success = $?

`ocelot #{gettysburg_file}`
ocelot_success = $?

unless cat_success.exitstatus == 0 && ocelot_success.exitstatus == 0
  fail "Failed 'cat and ocelot success exit codes match"
end

############################################################################

cat_out, cat_err, cat_process    = Open3.capture3("cat some_invalid_file")
ocelot_out, ocelot_err, ocelot_process = Open3.capture3("ocelot some_invalid_file") 

unless cat_process.exitstatus == 1 && ocelot_process.exitstatus == 1
  fail "Failed 'cat and ocelot exit codes match on bad file"
end

unless ocelot_err =~ /No such file or directory.*some_invalid_file/
  fail "Failed 'cat and ocelot error messages match on bad file'"
end

############################################################################


cat_out, cat_err, cat_proccess  = Open3.capture3("cat -x #{gettysburg_file}")
ocelot_out,ocelot_err, ocelot_process = Open3.capture3("ocelot -x #{gettysburg_file}") 

unless cat_process.exitstatus == 1 && ocelot_process.exitstatus == 1
  fail "Failed 'cat and ocelot exit codes match on bad switch"
end

unless ocelot_err == "ocelot: invalid option: -x\nusage: ocelot [-bns] [file ...]\n"
  fail "Failed 'ocelot provides usage instructions when given invalid option"
end

############################################################################

puts "You passed the tests, yay!"
