 # installed the ruby gem net-ssh to run this file.
 # the script has been tested with: ruby 2.0.0p481 (2014-05-08) [x64-mingw32]
 ########################################################################################################
 require 'rubygems'
 require 'net/ssh'
 
 
 # We will use the following user credentials to ssh to the remote host
 ########################################################################################################
 USER = 'scmbuild'
 PASS = 'Pa55word'
 host_input=""
 dest_folder=""
 
 
 # get user inputs for host name (there is scope for adding error handeling for getting the user inputs)
 ########################################################################################################
 puts " Please enter - the name of the remote host (for ed:  host.example.com  ):"
 host_input= gets.chomp
 HOST = host_input


 # get user inputs for host name (again scope for adding error handeling)
 ########################################################################################################
 puts " Please enter - the path to a directory on the remote host (for eg:  /dest  ):"
 dest_folder= gets.chomp
 DEST_FOLDER= dest_folder
 
 
 # Using SSH class to ssh on to the remote host with the USER/PASS
 # we store the output in the result and later store the output in a text file insde the working directory
 ########################################################################################################
 Net::SSH.start( HOST, USER, :password => PASS ) do|ssh|				
 ssh.exec!('cd DEST_FOLDER')
 result = ssh.exec!('du  --max-depth=1  | sort -rn | cut -f2')
 my_file= File.new("example.txt", 'w')
 my_file.puts result
 my_file.close
 end


 # get user inputs for an integer to get integer 'n'; so that we can display the nth largest folder name
 ########################################################################################################
 puts " Please enter the - nth largest subdirectory you would like to know in the remote host (kinldy supply an integer): "
 nth_largest= gets.to_i


 # use the already stored file to read the corrosponding line from the text file
 ########################################################################################################
 another_file= IO.readlines("example.txt")[nth_largest]
 puts "Number: #{nth_largest} largest folder in the remote host: " + HOST + " at the destination: " + DEST_FOLDER + " is:..." + another_file