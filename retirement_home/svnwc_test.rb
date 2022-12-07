require 'rubygems'
require 'svn_wc'
require 'ap'

    yconf = Hash.new
    yconf['svn_user']              = 'dvanhoozer'
    yconf['svn_pass']              = 'dvanhoozer'
    yconf['svn_repo_master']       = 'svn://tdv.local/ISE/branches/edge/Models/RubyModels/lib'
    yconf['svn_repo_working_copy'] = ENV['HOME']+'/tmp/lib'

    # 'do_checkout' is only needed until the local repository exists. (i.e. usually first time run only)
    # 'force' will plow over anything that may exist at the path.
    # i.e. if you ask for a do_checkout without force and the local repo exists, the call will fail

    svn = SvnWc::RepoAccess.new(YAML::dump(yconf), do_checkout=true, force=true)

    puts svn.svn_repo_master       # 'svn+ssh://www.example.com/svn_repository'
    puts svn.svn_user              # 'test_user'
    puts svn.svn_pass              # 'test_pass'
    puts svn.svn_repo_working_copy # '/opt/svn_repo'

    info = svn.info                # another way
    puts info[:root_url]           # 'svn+ssh://www.example.com/svn_repository'

    file = Tempfile.new('tmp', svn.svn_repo_working_copy).path
    begin
      svn.info(file)
    # SvnWc::RepoAccess' generic exeception class (the only one, raised for all exceptions)
    rescue SvnWc::RepoAccessError => e
      puts e.message.match(/is not under version control/)
    end

    svn.add file

    puts svn.commit file               # returns the revision number of the commit

    puts svn.status file               # ' ' empty string, file is current

    File.open(file, 'a') {|f| f.write('adding this to file.')}

    puts svn.status(file)[0][:status]  # 'M' (modified)
    # or, whole repo, multiple entries
    svn.status.each do |entries|
      puts "#{entries[:status]}\t#{entries[:path]}"
    end

    xxx = svn.info(file)
    ap xxx
    
    puts svn.diff(file)                # =~ 'adding this to file.'

    svn.revert file
    svn.commit file                    # -1 i.e commit failed, file is current

    svn.delete file
    svn.commit file                    # must commit our delete
