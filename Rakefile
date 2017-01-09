require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'metadata-json-lint/rake_task'

if RUBY_VERSION >= '1.9'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

excluded_paths = %w(
  pkg/**/*
  vendor/**/*
  .vendor/**/*
  spec/**/*
)

PuppetSyntax.exclude_paths = excluded_paths

PuppetLint.configuration.ignore_paths = excluded_paths
PuppetLint.configuration.fail_on_warnings
PuppetLint.configuration.send('relative')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_single_quote_string_with_variables')

desc 'Validate manifests, templates, and ruby files'
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    if ENV["FUTURE_PARSER"] == "yes"
      sh "puppet parser validate --parser future --noop #{manifest}"
    else
      sh "puppet parser validate --noop #{manifest}"
    end
  end
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{spec/fixtures}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

desc 'Run metadata_lint, lint, validate, and spec tests.'
task :test do
  [:metadata_lint, :lint, :validate, :spec].each do |test|
    Rake::Task[test].invoke
  end
end
