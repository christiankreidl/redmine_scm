require 'redmine'

begin
    require 'octokit'
rescue LoadError
end

Rails.logger.info 'Starting SCM Creator Plugin for Redmine'

Redmine::Scm::Base.add('Github')

unless Project.included_modules.include?(ScmProjectPatch)
    Project.send(:include, ScmProjectPatch)
end
unless Repository.included_modules.include?(ScmRepositoryPatch)
    Repository.send(:include, ScmRepositoryPatch)
end
unless RepositoriesHelper.included_modules.include?(ScmRepositoriesHelperPatch)
    RepositoriesHelper.send(:include, ScmRepositoriesHelperPatch)
end
unless RepositoriesController.included_modules.include?(ScmRepositoriesControllerPatch)
    RepositoriesController.send(:include, ScmRepositoriesControllerPatch)
end

Redmine::Plugin.register :redmine_scm do
    name        'SCM Creator'
    author      'Andriy Lesyuk'
    author_url  'http://www.andriylesyuk.com/'
    description 'Allows creating Subversion, Git, Mercurial, Bazaar and Github repositories within Redmine.'
    url         'https://github.com/ayaye/redmine_scm/'
    version     '0.6.0'
end
