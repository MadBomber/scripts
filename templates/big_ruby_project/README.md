# Big Ruby Project — asgard quality workflow

Scaffolding for a **multi-gem Ruby workspace**: a core gem plus `core-*`
extension gems (and optionally independent apps), all driven by
[asgard](https://github.com/MadBomber/asgard) loki tasks with a shared,
layered quality workflow.

Generated with: `cd new_project && new.rb big_ruby_project`

## Layout (self-contained — no external dependencies)

    .loki                 asgard entry point (imports the toolkit by walk-up)
    .envrc                RR + BUNDLE_GEMFILE=Gemfile.local (direnv)
    dev/                  per-component tasks, run inside ONE repo
      quality.loki          test · rubocop · flog · flay · reek · quality
      gem_tasks.loki        console · build · install · release
      git.loki              push · pull · fetch
      rubocop-strict.yml    always-on cops (never silenced)
    workspace/            cross-repo orchestration, run at the project root
      ws_repos.loki         auto-derived @@repos/@@gems/@@extensions/@@family/@@core
      ws_git.loki           clone · fetch · pull · push · branches · each
      ws_overview.loki      status · unpushed · paths · versions · check
      ws_quality.loki       test_all · quality_all (per-gate dashboard)
      ws_gems.loki          build_all · bundle_* · install_all · wire_local
      ws_sync.loki          sync_versions · bump_versions · set_env
    repo_dev.loki         shim each component imports via `import_up`
    .rubocop-base.yml     shared RuboCop config (components inherit it)
    .reek.yml             shared Reek config (found by walk-up)
    Rakefile.common       shared gem Rakefile (test/flog_check/flay_check)

## Nothing to configure

Everything is auto-detected from the filesystem:

- **repos**  = subdirectories that are git repos
- **gems**   = repos with a `*.gemspec`
- **core**   = the gem whose name prefixes the family (`foo` for `foo-*`)
- **extensions** = `core-*` gems that declare a dependency on `core`
- **github org** = parsed from the core gem's `origin` remote

## Onboarding a component gem

Each gem needs a tiny `.loki` (`import_up "repo_dev.loki"`), a thin
`.rubocop.yml` (`inherit_from: ../.rubocop-base.yml`), a `Gemfile.local`,
and a reek baseline (`asgard reek_baseline`). See any existing gem for the
pattern.

## Daily commands

    asgard help          # list everything
    asgard quality       # per-gate dashboard across all gems
    asgard status        # uncommitted changes across repos
    asgard push          # push every repo (delegates to each repo's push)
    asgard versions      # extension version lockstep vs core
