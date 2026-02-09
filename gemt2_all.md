# Installed Gems for Ruby 4.0.1 (1847)

## [Ascii85](https://github.com/DataWraith/ascii85gem/)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Johannes Holzfuß |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Ascii85 encoder/decoder

Ascii85 provides methods to encode/decode Adobe's binary-to-text encoding of the same name.

## [CFPropertyList](http://github.com/ckruse/CFPropertyList)

| | |
|---|---|
| **Version** | 2.3.6 |
| **Authors** | Christian Kruse |
| **License** | MIT |

Read, write and manipulate both binary and XML property lists as defined by apple

This is a module to read, write and manipulate both binary and XML property lists as defined by apple.

## [ParseTree](https://github.com/seattlerb/parsetree)

| | |
|---|---|
| **Version** | 3.0.9 |
| **Authors** | Ryan Davis |

ParseTree is a C extension (using RubyInline) that extracts the parse tree for an entire class or a specific method and returns it as a s-expression (aka sexp) using ruby's arrays, strings, symbols, and integers

ParseTree is a C extension (using RubyInline) that extracts the parse tree for an entire class or a specific method and returns it as a s-expression (aka sexp) using ruby's arrays, strings, symbols, and integers.  As an example:  def conditional1(arg1) if arg1 == 0 then return 1 end return 0 end  becomes:  [:defn, :conditional1, [:scope, [:block, [:args, :arg1], [:if, [:call, [:lvar, :arg1], :==, [:array, [:lit, 0]]], [:return, [:lit, 1]], nil], [:return, [:lit, 0]]]]]

**Dependencies:** RubyInline (~> 3.9.0), sexp_processor (~> 3.2.0)

## [RubyInline](http://rubyforge.org/projects/rubyinline/)

| | |
|---|---|
| **Version** | 3.9.0 |
| **Authors** | Ryan Davis |

Inline allows you to write foreign code within your ruby code

Inline allows you to write foreign code within your ruby code. It automatically determines if the code in question has changed and builds it only when necessary. The extensions are then automatically loaded into the class/module that defines it.  You can even write extra builders that will allow you to write inlined code in any language. Use Inline::C as a template and look at Module#inline for the required API.

**Dependencies:** ZenTest (~> 4.3)

## [RubyToC](http://rubyforge.org/projects/ruby2c/)

| | |
|---|---|
| **Version** | 1.0.0.5 |
| **Authors** | Ryan Davis |
| **Ruby** | > 0.0.0 |

Ruby (subset) to C translator.

ruby_to_c translates a static ruby subset to C. Hopefully it works.

**Dependencies:** ParseTree (> 0.0.0)

## [ZenTest](https://github.com/seattlerb/zentest)

| | |
|---|---|
| **Version** | 4.12.2 |
| **Authors** | Ryan Davis, Eric Hodel |
| **License** | MIT |

ZenTest provides 4 different tools: zentest, unit_diff, autotest, and multiruby

ZenTest provides 4 different tools: zentest, unit_diff, autotest, and multiruby.  zentest scans your target and unit-test code and writes your missing code based on simple naming rules, enabling XP at a much quicker pace. zentest only works with Ruby and Minitest or Test::Unit. There is enough evidence to show that this is still proving useful to users, so it stays.  unit_diff is a command-line filter to diff expected results from actual results and allow you to quickly see exactly what is wrong. Do note that minitest 2.2+ provides an enhanced assert_equal obviating the need for unit_diff  autotest is a continous testing facility meant to be used during development. As soon as you save a file, autotest will run the corresponding dependent tests.  multiruby runs anything you want on multiple versions of ruby. Great for compatibility checking! Use multiruby_setup to manage your installed versions.  *NOTE:* The next major release of zentest will not include autotest (use minitest-autotest instead) and multiruby will use rbenv / ruby-build for version management.

## [aasm](https://github.com/aasm/aasm)

| | |
|---|---|
| **Version** | 5.5.2 |
| **Authors** | Thorsten Boettger, Anil Maurya |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

State machine mixin for Ruby objects

AASM is a continuation of the acts-as-state-machine rails plugin, built for plain Ruby objects.

**Dependencies:** concurrent-ruby (~> 1.0)

## [abbrev](https://github.com/ruby/abbrev)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Akinori MUSHA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Calculates a set of unique abbreviations for a given set of strings

## [action_policy](https://github.com/palkan/action_policy)

| | |
|---|---|
| **Version** | 0.7.6 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Authorization framework for Ruby/Rails application

**Dependencies:** ruby-next-core (>= 1.0)

## [action_prompt](https://github.com/evdevdev/action_prompt)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Evan Arnold |
| **License** | MIT |

ActionPrompt is a Rails plugin for managing templated LLM prompts

**Dependencies:** rails (>= 7.2.1)

## [action_push_native](https://github.com/basecamp/action_push_native)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Jacopo Beschi |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Send push notifications to mobile apps

**Dependencies:** activerecord (>= 8.0), activejob (>= 8.0), railties (>= 8.0), httpx (~> 1.6), jwt (>= 2), googleauth (~> 1.14)

## [action_text-trix](https://github.com/basecamp/trix)

| | |
|---|---|
| **Version** | 2.1.16 |
| **Authors** | 37signals, LLC |
| **License** | MIT |

A rich text editor for everyday writing

**Dependencies:** railties (>= 0)

## [actioncable](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | Pratik Naik, David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

WebSocket framework for Rails.

Structure many real-time application concerns into channels over a single WebSocket connection.

**Dependencies:** activesupport (= 7.2.3), actionpack (= 7.2.3), nio4r (~> 2.0), websocket-driver (>= 0.6.1), zeitwerk (~> 2.6)

## [actioncable-next](https://github.com/anycable/action_cable-next)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Pratik Naik, David Heinemeier Hansson, Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Next-gen version of Action Cable

**Dependencies:** activesupport (>= 7.0, <= 8.2), actionpack (>= 7.0, <= 8.2), nio4r (~> 2.0), websocket-driver (>= 0.6.1), zeitwerk (~> 2.6)

## [actionmailbox](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson, George Claghorn |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Inbound email handling framework.

Receive and process incoming emails in Rails applications.

**Dependencies:** activesupport (= 7.2.3), activerecord (= 7.2.3), activestorage (= 7.2.3), activejob (= 7.2.3), actionpack (= 7.2.3), mail (>= 2.8.0)

## [actionmailer](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Email composition and delivery framework (part of Rails).

Email on Rails. Compose, deliver, and test emails using the familiar controller/view pattern. First-class support for multipart email and attachments.

**Dependencies:** activesupport (= 7.2.3), actionpack (= 7.2.3), actionview (= 7.2.3), activejob (= 7.2.3), mail (>= 2.8.0), rails-dom-testing (~> 2.2)

## [actionmcp](https://github.com/seuros/action_mcp)

| | |
|---|---|
| **Version** | 0.104.1 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |

Lightweight Model Context Protocol (MCP) server toolkit for Ruby/Rails

A streamlined, production-focused toolkit for building MCP servers in Rails applications. Provides essential base classes, authentication gateways, and HTTP transport with minimal dependencies.

**Dependencies:** activejob (>= 8.1.0), activerecord (>= 8.1.0), concurrent-ruby (>= 1.3.1), jsonrpc-rails (>= 0.5.3), multi_json (>= 0), railties (>= 8.1.0), zeitwerk (~> 2.6), state_machines-activerecord (>= 0.100.0)

## [actionpack](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Web-flow and rendering framework putting the VC in MVC (part of Rails).

Web apps on Rails. Simple, battle-tested conventions for building and testing MVC web applications. Works with any Rack-compatible server.

**Dependencies:** activesupport (= 7.2.3), cgi (>= 0), nokogiri (>= 1.8.5), racc (>= 0), rack (>= 2.2.4, < 3.3), rack-session (>= 1.0.1), rack-test (>= 0.6.3), rails-html-sanitizer (~> 1.6), rails-dom-testing (~> 2.2), useragent (~> 0.16), actionview (= 7.2.3)

## [actiontext](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | Javan Makhmali, Sam Stephenson, David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Rich text framework.

Edit and display rich text in Rails applications.

**Dependencies:** activesupport (= 7.2.3), activerecord (= 7.2.3), activestorage (= 7.2.3), actionpack (= 7.2.3), nokogiri (>= 1.8.5), globalid (>= 0.6.0)

## [actionview](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Rendering framework putting the V in MVC (part of Rails).

Simple, battle-tested conventions and helpers for building web pages.

**Dependencies:** activesupport (= 7.2.3), cgi (>= 0), builder (~> 3.1), erubi (~> 1.11), rails-html-sanitizer (~> 1.6), rails-dom-testing (~> 2.2)

## [active_flag](https://github.com/kenn/active_flag)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Kenn Ejima |

Bit array for ActiveRecord

**Dependencies:** activerecord (>= 5)

## [active_genie](https://github.com/Roriz/active_genie)

| | |
|---|---|
| **Version** | 0.30.8 |
| **Authors** | Radamés Roriz |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.4.0 |

The Lodash for GenAI: Consistent + Model-Agnostic

ActiveGenie is an enabler for creating reliable GenAI features, offering powerful, model-agnostic tools across any provider. It allows you to settle subjective comparisons with a `ActibeGenie::Comparator` module that stages a political debate, get accurate scores from an AI jury using `ActiveGenie::Scorer`, and rank large datasets using `ActiveGenie::Ranker`'s tournament-style system. This reliability is built on three core pillars: - Custom Benchmarking: Testing for consistency with every new version and model update. - Reasoning Prompting: Utilizing human reasoning techniques (like debate and jury review) to control a model's reasoning. - Overfitting Prompts: Highly specialized, and potentially model-specific, prompt for each module's purpose.

**Dependencies:** async (~> 2.0)

## [active_hash](http://github.com/active-hash/active_hash)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Jeff Dean, Mike Dalessio, Corey Innis, Peter Jaros, Brandon Keene, Brian Takita, Pat Nakajima, John Pignata, Michael Schubert, Jeremy Weiskotten, Ryan Garver, Tom Stuart, Joel Chippindale, Kevin Olsen, Vladimir Andrijevik, Adam Anderson, Keenan Brock, Desmond Bowe, Matthew O'Riordan, Brett Richardson, Rachel Heaton, Keisuke Izumiya |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

An ActiveRecord-like model that uses a hash or file as a datasource

Includes the ability to specify data using hashes, yml files or JSON files

**Dependencies:** activesupport (>= 6.1.0)

## [active_link_to](http://github.com/comfy/active_link_to)

| | |
|---|---|
| **Version** | 1.0.5 |
| **Authors** | Oleg Khabarov |

ActionView helper to render currently active links

Helpful method when you need to add some logic that figures out if the link (or more often navigation item) is selected based on the current page or other arbitrary condition

**Dependencies:** actionpack (>= 0), addressable (>= 0)

## [active_median](https://github.com/ankane/active_median)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Median and percentile for Active Record, Mongoid, arrays, and hashes

**Dependencies:** activesupport (>= 7.1)

## [active_model-relation](https://github.com/userlist/active_model-relation/)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Benedikt Deicke |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Query collections of ActiveModel objects like an ActiveRecord::Relation

This library allows querying of collections of Ruby objects, with a similar interface to ActiveRecord::Relation.

**Dependencies:** activemodel (>= 7.2)

## [active_model_serializers](https://github.com/rails-api/active_model_serializers)

| | |
|---|---|
| **Version** | 0.10.16 |
| **Authors** | Steve Klabnik |
| **License** | MIT |
| **Ruby** | >= 2.1 |

Conventions-based JSON generation for Rails.

ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.

**Dependencies:** activemodel (>= 4.1), actionpack (>= 4.1), jsonapi-renderer (>= 0.1.1.beta1, < 0.3), case_transform (>= 0.2)

## [active_pinecone](https://github.com/moekidev/active_pinecone)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Moeki Kawakami |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

ActiveRecord-esque base class that lets you use Pinecone.

**Dependencies:** activesupport (>= 5.0.0), pinecone (~> 0.1.5), ruby-openai (~> 4.1.0)

## [active_record-associated_object](https://github.com/kaspth/active_record-associated_object)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Kasper Timm Hansen |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Associate a Ruby PORO with an Active Record class and have it quack like one.

**Dependencies:** activerecord (>= 6.1)

## [active_record_extended](https://github.com/georgekaraszi/ActiveRecordExtended)

| | |
|---|---|
| **Version** | 3.4.0 |
| **Authors** | George Protacio-Karaszi, Dan McClain, Olivier El Mekki |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Adds extended functionality to Activerecord Postgres implementation

**Dependencies:** activerecord (>= 5.2, < 8.1), pg (< 3.0)

## [active_record_tracer](https://github.com/fatkodima/active_record_tracer)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | fatkodima |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A tracer for Active Record queries

**Dependencies:** activerecord (>= 7.0)

## [active_record_union](https://github.com/brianhempel/active_record_union)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Brian Hempel |
| **License** | Public Domain |

UNIONs in ActiveRecord! Adds proper union and union_all methods to ActiveRecord::Relation.

**Dependencies:** activerecord (>= 6.0)

## [active_snapshot](https://github.com/westonganger/active_snapshot)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Weston Ganger |
| **License** | MIT |

Dead simple snapshot versioning for ActiveRecord models and associations.

**Dependencies:** activerecord (>= 6.1), railties (>= 0)

## [active_type](https://github.com/makandra/active_type)

| | |
|---|---|
| **Version** | 2.8.0 |
| **Authors** | Tobias Kraze, Henning Koch |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Make any Ruby object quack like ActiveRecord

**Dependencies:** activerecord (>= 6.1)

## [activeagent](https://activeagents.ai)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Justin Bowen |
| **License** | MIT |

Rails AI Agents Framework

The only agent-oriented AI framework designed for Rails, where Agents are Controllers. Build AI features with less complexity using the MVC conventions you love.

**Dependencies:** actionpack (>= 7.2, <= 9.0), actionview (>= 7.2, <= 9.0), activesupport (>= 7.2, <= 9.0), activemodel (>= 7.2, <= 9.0), activejob (>= 7.2, <= 9.0)

## [activecypher](https://github.com/seuros/activecypher)

| | |
|---|---|
| **Version** | 0.14.2 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.4.0 |

OpenCypher Adapter ala ActiveRecord

**Dependencies:** activemodel (~> 8.0), async (>= 2.34.0), async-pool (>= 0.11.1), io-endpoint (~> 0.14), io-event (~> 1.10), io-stream (~> 0.6)

## [activegraph](https://github.com/neo4jrb/activegraph/)

| | |
|---|---|
| **Version** | 11.4.0 |
| **Authors** | Andreas Ronge, Brian Underwood, Chris Grigg, Heinrich Klobuczek |
| **License** | MIT |
| **Ruby** | >= 2.6 |

A graph database for Ruby

A Neo4j OGM (Object-Graph-Mapper) for Ruby heavily inspired by ActiveRecord.

**Dependencies:** activemodel (>= 4.0), activesupport (>= 4.0), i18n (!= 1.8.8), neo4j-ruby-driver (>= 4.4.1), orm_adapter (~> 0.5.0), sorted_set (>= 0)

## [activejob](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Job framework with pluggable queues.

Declare job classes that can be run by a variety of queuing backends.

**Dependencies:** activesupport (= 7.2.3), globalid (>= 0.3.6)

## [activematrix](https://github.com/seuros/activematrix)

| | |
|---|---|
| **Version** | 0.0.15 |
| **Authors** | Abdelkader Boudih, Alexander Olofsson |
| **License** | MIT |
| **Ruby** | >= 3.4 |

Rails-native Matrix SDK for building multi-agent bot systems and real-time communication

ActiveMatrix is a comprehensive Rails-native Matrix SDK that enables developers to build sophisticated multi-agent bot systems and real-time communication features. This gem provides deep Rails integration with ActiveRecord models, state machines for bot lifecycle management, multi-tiered memory systems, intelligent event routing, connection pooling, and built-in inter-agent communication. Perfect for building chatbots, automation systems, monitoring agents, and collaborative AI systems within Rails applications. Features include command handling, room management, media support, end-to-end encryption capabilities, and extensive protocol support (CS, AS, IS, SS).

**Dependencies:** activejob (>= 8.0, < 9), activerecord (>= 8.0, < 9), async (>= 2.21), async-http (>= 0.86), bcrypt (~> 3.1), railties (>= 8.0, < 9), pg (>= 1.6), state_machines-activerecord (>= 0.100.0), thor (>= 1.0), zeitwerk (~> 2.6)

## [activemodel](http://www.rubyonrails.org)

| | |
|---|---|
| **Version** | 3.2.22.5 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

A toolkit for building modeling frameworks (part of Rails).

A toolkit for building modeling frameworks like Active Record and Active Resource. Rich support for attributes, callbacks, validations, observers, serialization, internationalization, and testing.

**Dependencies:** activesupport (= 3.2.22.5), builder (~> 3.0.0)

## [activemodel-serializers-xml](http://github.com/rails/activemodel-serializers-xml)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Rails team |
| **License** | MIT |

XML serialization for your Active Model objects and Active Record models - extracted from Rails

**Dependencies:** activesupport (>= 5.0.0.a), activemodel (>= 5.0.0.a), builder (~> 3.1)

## [activeproject](https://github.com/seuros/active_project)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |

A standardized Ruby interface for multiple project management APIs (Jira, Basecamp, Trello, etc.).

Provides a unified API client for interacting with various project management platforms like Jira, Basecamp, and Trello. Aims to normalize core models (projects, tasks, comments) and workflows for easier integration in Rails applications.

**Dependencies:** activesupport (>= 8.0, < 9.0), async (>= 2.35), async-http (>= 0.92), async-http-faraday (>= 0.22), concurrent-ruby (>= 1.2), faraday (>= 2.0), faraday-retry (>= 0)

## [activerecord](http://www.rubyonrails.org)

| | |
|---|---|
| **Version** | 3.2.22.5 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

Object-relational mapper framework (part of Rails).

Databases on Rails. Build a persistent domain model by mapping database tables to Ruby classes. Strong conventions for associations, validations, aggregations, migrations, and testing come baked-in.

**Dependencies:** activesupport (= 3.2.22.5), activemodel (= 3.2.22.5), arel (~> 3.0.2), tzinfo (~> 0.3.29)

## [activerecord-has_some_of_many](https://github.com/bensheldon/activerecord-has_some_of_many)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Ben Sheldon [he/him] |
| **License** | MIT |

An Active Record extension for creating associations through lateral joins

**Dependencies:** activerecord (>= 7.0.0.alpha), railties (>= 7.0.0.alpha)

## [activerecord-import](https://github.com/zdennis/activerecord-import)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Zach Dennis |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Bulk insert extension for ActiveRecord

A library for bulk inserting data using ActiveRecord.

**Dependencies:** activerecord (>= 4.2)

## [activerecord-postgis](https://github.com/seuros/activerecord-postgis)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

PostGIS Type support for ActiveRecord

**Dependencies:** activerecord (>= 8.1.0, < 8.2), pg (>= 0), rgeo-activerecord (>= 8.0)

## [activerecord-tenanted](https://github.com/basecamp/activerecord-tenanted)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Mike Dalessio |
| **License** | MIT |

Enable a Rails application to have separate databases for each tenant.

Enable a Rails application to have separate databases for each tenant.  This gem primarily extends Active Record, creating a new connection pool for each tenant and using horizontal sharding to swap between them. It also provides integrations for middleware tenant selection, Action View Caching, Active Job, Action Cable, Active Storage, Action Mailbox, and Action Text, with support and documentation for Solid Cache, Solid Queue, Solid Cable, and Turbo Rails.

**Dependencies:** activerecord (>= 8.1.beta), railties (>= 8.1.beta), zeitwerk (>= 0)

## [activeresource](http://www.rubyonrails.org)

| | |
|---|---|
| **Version** | 6.2.0 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

REST modeling framework (part of Rails).

REST on Rails. Wrap your RESTful web app with Ruby classes and work with them like Active Record models.

**Dependencies:** activesupport (>= 7.0), activemodel (>= 7.0), activemodel-serializers-xml (~> 1.0)

## [activestorage](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Local and cloud file storage framework.

Attach cloud and local files in Rails applications.

**Dependencies:** activesupport (= 7.2.3), actionpack (= 7.2.3), activejob (= 7.2.3), activerecord (= 7.2.3), marcel (~> 1.0)

## [activesupport](http://www.rubyonrails.org)

| | |
|---|---|
| **Version** | 3.1.12 |
| **Authors** | David Heinemeier Hansson |
| **Ruby** | >= 1.8.7 |

A toolkit of support libraries and Ruby core extensions extracted from the Rails framework.

A toolkit of support libraries and Ruby core extensions extracted from the Rails framework. Rich support for multibyte strings, internationalization, time zones, and testing.

**Dependencies:** multi_json (~> 1.0)

## [acts_as_graph_vertex](https://github.com/nathankleyn/acts_as_graph_vertex)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Nathan Kleyn |
| **License** | MIT |

Simple mixin for adding graph like functions (parents, children, traversal, etc) to any class.

Simple mixin for adding graph like functions (parents, children, traversal, etc) to any class. Effectively, you'll get DAG (directed acyclic graph) behaviour between your classes and therefore the ability to model parent, child and sibling behaviours with ease!

## [acts_as_list](https://github.com/brendon/acts_as_list)

| | |
|---|---|
| **Version** | 1.2.6 |
| **Authors** | Swanand Pagnis, Brendon Muir |
| **License** | MIT |
| **Ruby** | >= 2.5 |

A gem adding sorting, reordering capabilities to an active_record model, allowing it to act as a list

This "acts_as" extension provides the capabilities for sorting and reordering a number of objects in a list. The class that has this specified needs to have a "position" column defined as an integer on the mapped database table.

**Dependencies:** activerecord (>= 6.1), activesupport (>= 6.1)

## [acts_as_paranoid](https://github.com/ActsAsParanoid/acts_as_paranoid)

| | |
|---|---|
| **Version** | 0.11.0 |
| **Authors** | Zachary Scott, Goncalo Silva, Rick Olson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Active Record plugin which allows you to hide and restore records without actually deleting them.

Check the home page for more in-depth information.

**Dependencies:** activerecord (>= 6.1, < 8.2), activesupport (>= 6.1, < 8.2)

## [acts_as_recursive_tree](https://github.com/1and1/acts_as_recursive_tree)

| | |
|---|---|
| **Version** | 4.1.0 |
| **Authors** | Wolfgang Wedelich-John, Willem Mulder |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Drop in replacement for acts_as_tree but using recursive queries

This is a ruby gem that provides drop in replacement for acts_as_tree but makes use of SQL recursive statement. Be sure to have a DBMS that supports recursive queries when using this gem (e.g. PostgreSQL or SQLite).

**Dependencies:** activerecord (>= 7.0.0, < 9), activesupport (>= 7.0.0, < 9), zeitwerk (>= 2.4)

## [address_extractor](http://github.com/coderifous/address_extractor)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Jim Garvin |

Give it text.  It finds addresses in it.

## [addressable](https://github.com/sporkmonger/addressable)

| | |
|---|---|
| **Version** | 2.8.8 |
| **Authors** | Bob Aman |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.2 |

URI Implementation

Addressable is an alternative implementation to the URI implementation that is part of Ruby's standard library. It is flexible, offers heuristic parsing, and additionally provides extensive support for IRIs and URI templates.

**Dependencies:** public_suffix (>= 2.0.2, < 8.0)

## [administrate](https://administrate-demo.herokuapp.com/)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Nick Charlton |
| **License** | MIT |

A Rails engine for creating super-flexible admin dashboards

Administrate is a library for Rails that generates admin dashboards. These give users clean interfaces that allow them to create, edit, search, and delete records for any model in the application. Administrate aims to provide the best user experience, and doing as much work as possible for you, whilst also being flexible to customise.

**Dependencies:** actionpack (>= 6.0, < 9.0), actionview (>= 6.0, < 9.0), activerecord (>= 6.0, < 9.0), kaminari (~> 1.2.2)

## [aes_key_wrap](https://github.com/tomdalling/aes_key_wrap)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Tom Dalling |
| **License** | MIT |

A Ruby implementation of AES Key Wrap, a.k.a RFC 3394, a.k.a NIST Key Wrap.

## [afm](http://github.com/halfbyte/afm)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Jan Krutisch |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

reading Adobe Font Metrics (afm) files

a simple library to read afm files and use the data conveniently

## [after_commit_everywhere](https://github.com/Envek/after_commit_everywhere)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Andrey Novikov |
| **License** | MIT |

Executes code after database commit wherever you want in your application

Brings before_commit, after_commit, and after_rollback transactional callbacks outside of your ActiveRecord models.

**Dependencies:** activerecord (>= 4.2), activesupport (>= 0)

## [agent-context](https://github.com/ioquatix/agent-context)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Samuel Williams, Shopify Inc. |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Install and manage context files from Ruby gems.

**Dependencies:** bake (>= 0.23)

## [agent99](https://github.com/MadBomber/agent99)

| | |
|---|---|
| **Version** | 0.0.5 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

An intelligent agent framework for Ruby

`agent99` is a Ruby gem designed to facilitate the creation and management of smart agents, providing a straightforward interface for tasks such as natural language processing, context handling, and conversing with various AI models. It allows developers to smoothly integrate and utilize AI capabilities within Ruby applications while ensuring flexibility and ease of customization.

**Dependencies:** bunny (>= 0), nats-pure (>= 0), simple_json_schema_builder (>= 0), sinatra (>= 0)

## [agentic](https://github.com/codenamev/agentic)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Valentino Stoll |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

An AI Agent builder and orchestrator

Easily build, manage, deploy, and run self-contained purpose-driven AI Agents.

**Dependencies:** dry-schema (>= 0), ruby-openai (>= 0), zeitwerk (>= 0), async (~> 2.0), thor (~> 1.2), tty-spinner (~> 0.9), tty-progressbar (~> 0.18), tty-box (~> 0.7), tty-table (~> 0.12), tty-cursor (~> 0.7), pastel (~> 0.8), ostruct (>= 0)

## [agile_rails](https://agile-rails.com)

| | |
|---|---|
| **Version** | 0.0.0.3 |
| **Authors** | Damjan Rems |
| **License** | MIT |
| **Ruby** | > 3.1 |

AgileRails: Agile business application development tool and CMS for Ruby on Rails

AgileRails, development tool for agile development of in-house (Intranet, business, private cloud) applications as well as CMS for creating complex, data-entry intensive web sites.

**Dependencies:** jquery-rails (>= 0), jquery-ui-rails (>= 0), non-digest-assets (>= 0), rails (>= 0), bcrypt (>= 0), drg_material_icons (>= 0), kaminari (>= 0), kaminari-actionview (>= 0)

## [ahoy](http://github.com/matsadler/ahoy)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Mat Sadler |

Bonjour Chat for Ruby

Serverless Messaging using DNSDS/mDNS, XMPP, and Ruby

**Dependencies:** dnssd (>= 1.3.1), xmpp4r (= 0.5)

## [ahoy_matey](https://github.com/ankane/ahoy)

| | |
|---|---|
| **Version** | 5.4.1 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Simple, powerful, first-party analytics for Rails

**Dependencies:** activesupport (>= 7.1), device_detector (>= 1), safely_block (>= 0.4)

## [ai-agents](https://chatwoot.com/ai-agents)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Shivam Mishra |
| **Ruby** | >= 3.2.0 |

A Ruby SDK for building sophisticated multi-agent AI workflows

Ruby AI Agents SDK enables creating complex AI workflows with multi-agent orchestration, tool execution, safety guardrails, and provider-agnostic LLM integration.

**Dependencies:** ruby_llm (~> 1.9.1)

## [ai-engine](https://railsai.com/docs/installation)

| | |
|---|---|
| **Version** | 0.4.2 |
| **Authors** | Alex Rudall |
| **License** | MIT |
| **Ruby** | >= 3.0 |

The fastest way to get AI Assistants into your Rails app!

**Dependencies:** ruby-openai (~> 7.1.0)

## [ai_client](https://github.com/MadBomber/ai_client)

| | |
|---|---|
| **Version** | 0.4.6 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A generic AI Client for many providers

`ai_client` is a versatile Ruby gem that offers a seamless interface for integrating a wide range of AI service providers through a single, unified API. With `ai_client`, you can simply specify the model name and quickly leverage advanced features such as chatting, transcription, and speech synthesis. The gem supports prominent providers, including OpenAI, Anthropic, Google, Mistral, LocalAI, Ollama, and OpenRouter, making it easier than ever to build innovative applications. Plus, its flexible middleware architecture allows for easy customization of request and response handling, ensuring that you can harness the power of AI without vendor lock-in.

**Dependencies:** active_hash (>= 0), hashie (>= 0), omniai (>= 0), omniai-anthropic (>= 0), omniai-google (>= 0), omniai-mistral (>= 0), omniai-openai (>= 1.8.3), open_router (>= 0)

## [ai_guardrails](https://github.com/logicbunchhq/ai_guardrails)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Faisal Raza |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

AiGuardrails: Schema validation and safety layer for AI-generated output in Ruby

AiGuardrails is a Ruby gem that helps developers validate, correct, and enforce schemas on AI-generated outputs. It ensures structured data, prevents JSON errors, and provides a foundation for adding safety filters and auto-correction in Rails apps, CLI tools, background jobs, and scrapers. Think of it as Guardrails.AI for Ruby.

**Dependencies:** dry-validation (~> 1.10)

## [ai_screen_analyzer](https://github.com/mcfox/ai_screen_analyzer)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | José Lopes Neto |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Rails helper gem para analisar telas com IA usando GPT-4V

AI Screen Analyzer é uma gem Rails que adiciona um botão flutuante em qualquer página para capturar a tela, enviar para análise com GPT-4V e exibir o resultado em uma barra lateral elegante.

**Dependencies:** rails (>= 6.0)

## [aia](https://github.com/MadBomber/aia)

| | |
|---|---|
| **Version** | 1.0.0.pre.alpha |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Multi-model AI CLI with dynamic prompts, consensus responses, shell & Ruby integration, and seamless chat workflows.

AIA is a revolutionary CLI console application that brings multi-model AI capabilities to your command line, supporting 20+ providers including OpenAI, Anthropic, and Google. Run multiple AI models simultaneously for comparison, get consensus responses from collaborative AI teams, or compare individual outputs side-by-side. With dynamic prompt management, embedded directives, shell and Ruby integration, interactive chats, and comprehensive history tracking, AIA transforms how you interact with AI. Perfect for developers and AI enthusiasts who want to harness the collective intelligence of multiple AI models from a single, powerful interface.

**Dependencies:** amazing_print (>= 0), async (>= 0), clipboard (>= 0), faraday (>= 0), lumberjack (>= 0), myway_config (>= 0), prompt_manager (~> 1.0.1), reline (>= 0), ruby_llm (>= 0), ruby_llm-mcp (>= 0), shellwords (>= 0), simple_flow (>= 0), tty-screen (>= 0), tty-spinner (>= 0), word_wrapper (>= 0)

## [aicommit](https://github.com/jackal998/aicommit)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | jackal998, LinGaryTW |
| **License** | MIT |

Use your own spell against you.

You dare use my own spells against me, Human?

**Dependencies:** git (~> 1.14.0), ruby-openai (~> 3.4.0), dotenv (~> 2.8.1)

## [aider-ruby](https://github.com/renaudgagnon/aider-ruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Renaud Gagnon |
| **License** | MIT |

Ruby wrapper for aider - AI pair programming tool

A Ruby gem that provides a wrapper for aider, enabling configuration of LLMs and execution of tasks through command line interface

**Dependencies:** json (~> 2.0), open3 (~> 0.1), thor (~> 1.0), yaml (~> 0.1)

## [aigcm](https://github.com/MadBomber/aigcm)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

AI-powered git commit message generator

An advanced AI-powered git commit message generator. It leverages multiple AI providers including OpenAI, Anthropic, Google, and local models via Ollama to create meaningful and contextual commit messages. This gem streamlines the commit process, ensuring consistent and informative version control practices across projects.

**Dependencies:** ruby_llm (>= 0)

## [airb](https://github.com/sublayerapp/airb)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Scott Werner |
| **License** | MIT |
| **Ruby** | >= 3.4 |

CLI-based programming agent for Ruby with VSM architecture

airb is an open-source CLI programming agent that helps developers build software using modern LLMs (OpenAI, Anthropic, Gemini). Built on a clean, composable architecture inspired by Stafford Beer's Viable System Model, it features streaming responses, structured tool calling, built-in file operations, and optional web-based observability. Designed for hackability with small objects, clear seams, and UNIXy ergonomics.

**Dependencies:** vsm (~> 0.1)

## [airbrussh](https://github.com/mattbrictson/airbrussh)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Matt Brictson |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Airbrussh pretties up your SSHKit and Capistrano output

A replacement log formatter for SSHKit that makes Capistrano output much easier on the eyes. Just add Airbrussh to your Capfile and enjoy concise, useful log output that is easy to read.

**Dependencies:** sshkit (>= 1.6.1, != 1.7.0)

## [aircana](https://github.com/westonkd/aircana)

| | |
|---|---|
| **Version** | 5.2.6 |
| **Authors** | Weston Dransfield |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

CLI for creating and managing Claude Code plugins with per-agent knowledge bases

Aircana generates distributable Claude Code plugins with specialized agents backed by Confluence and web knowledge sources. Includes manifest-based knowledge tracking, ERB template generation, and team collaboration features.

**Dependencies:** aws-sdk-bedrockruntime (~> 1.0), httparty (~> 0.21), reverse_markdown (~> 2.1), thor (~> 0.19.1), tty-progressbar (~> 0.18), tty-prompt (~> 0.23.1), tty-spinner (~> 0.9)

## [ak47](https://rubygems.org/gems/ak47)

| | |
|---|---|
| **Version** | 0.2.5 |
| **Authors** | Josh Hull |

Reload anything

Reload anything.

**Dependencies:** guard (~> 0.10.0), shell_tools (~> 0.1.0), smart_colored (>= 0)

## [akami](https://github.com/savonrb/akami)

| | |
|---|---|
| **Version** | 1.3.3 |
| **Authors** | Daniel Harrington |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Web Service Security

Building Web Service Security

**Dependencies:** gyoku (>= 0.4.0), nokogiri (>= 0), base64 (>= 0)

## [alba](https://github.com/okuramasafumi/alba)

| | |
|---|---|
| **Version** | 3.10.0 |
| **Authors** | OKURA Masafumi |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Alba is a JSON serializer for Ruby, JRuby and TruffleRuby.

Alba is a JSON serializer for Ruby, JRuby and TruffleRuby. It focuses on performance, flexibility and usability.

## [alchemy-devise](https://alchemy-cms.com)

| | |
|---|---|
| **Version** | 8.0.1 |
| **Authors** | Thomas von Deyen |

Devise based user authentication for AlchemyCMS.

**Dependencies:** alchemy_cms (>= 8.0.0.a, < 9.0), devise (~> 4.9), flickwerk (~> 0.3.6)

## [alchemy_cms](https://alchemy-cms.com)

| | |
|---|---|
| **Version** | 8.0.7 |
| **Authors** | Thomas von Deyen, Robin Boening, Marc Schettke, Hendrik Mans, Carsten Fregin, Martin Meyerhoff |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.1.0 |

A powerful, userfriendly and flexible CMS for Rails

Alchemy is a powerful, userfriendly and flexible Rails CMS.

**Dependencies:** actionmailer (>= 7.1, < 8.1), actionpack (>= 7.1, < 8.1), actionview (>= 7.1, < 8.1), activejob (>= 7.1, < 8.1), activemodel (>= 7.1, < 8.1), activerecord (>= 7.1, < 8.1), activestorage (>= 7.1, < 8.1), activesupport (>= 7.1, < 8.1), railties (>= 7.1, < 8.1), active_model_serializers (~> 0.10.14), acts_as_list (>= 0.3, < 2), awesome_nested_set (~> 3.1, >= 3.7.0), cancancan (>= 2.1, < 4.0), csv (~> 3.3), dragonfly (~> 1.4), gutentag (>= 2.2.1, < 4.0), image_processing (~> 1.14), importmap-rails (~> 2.0), kaminari (~> 1.1), originator (~> 3.1), ransack (>= 1.8, < 5.0), simple_form (>= 4.0, < 6), turbo-rails (>= 1.4, < 2.1), view_component (>= 3, < 5)

## [algolia_html_extractor](https://github.com/algolia/html-extractor)

| | |
|---|---|
| **Version** | 2.6.4 |
| **Authors** | Tim Carry |
| **License** | MIT |

Convert HTML content into Algolia records

Take any arbitrary HTML as input and extract its content as a list of records, including contents and hierarchy.

**Dependencies:** json (~> 2.0), nokogiri (~> 1.10)

## [algoliasearch](https://github.com/algolia/algoliasearch-client-ruby)

| | |
|---|---|
| **Version** | 1.27.5 |
| **Authors** | Algolia |
| **License** | MIT |

A simple Ruby client for the algolia.com REST API

**Dependencies:** json (>= 1.5.1), httpclient (~> 2.8, >= 2.8.3)

## [alias](http://tagaholic.me/alias/)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Gabriel Horner |
| **License** | MIT |

Creates, manages and saves aliases for class methods, instance methods, constants, delegated methods and more.

Creates aliases for class methods, instance methods, constants, delegated methods and more. Aliases can be easily searched or saved as YAML config files to load later. Custom alias types are easy to create with the DSL Alias provides.  Although Alias was created with the irb user in mind, any Ruby console program can hook into Alias for creating configurable aliases.

## [alphavantage](https://github.com/codespore/alphavantage_ruby)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Adrian Teh |
| **License** | MIT |

Ruby library for Alpha Vantage API

Ruby library for the Alpha Vantage API, a leading provider of stock APIs as well as forex (FX) and cryptocurrency data feeds.

**Dependencies:** faraday (~> 1.4), hashie (~> 4.1)

## [amalgalite](http://github.com/copiousfreetime/amalgalite)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Jeremy Hinegardner |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.1.0 |

Amalgalite embeds the SQLite database engine as a ruby extension. There is no need to install SQLite separately.

Amalgalite embeds the SQLite database engine as a ruby extension. There is no need to install SQLite separately.

**Dependencies:** csv (~> 3.3)

## [amatch](http://github.com/flori/amatch)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Florian Frank |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.4 |

Approximate String Matching library

Amatch is a library for approximate string matching and searching in strings. Several algorithms can be used to do this, and it's also possible to compute a similarity metric number between 0.0 and 1.0 for two given strings.

**Dependencies:** tins (~> 1), mize (>= 0)

## [amazing_print](https://github.com/amazing-print/amazing_print)

| | |
|---|---|
| **Version** | 1.8.1 |
| **Authors** | Michael Dvorkin, Kevin McCormack, Patrik Wenger |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Pretty print Ruby objects with proper indentation and colors

Great Ruby debugging companion: pretty print Ruby objects to visualize their structure. Supports custom object formatting via plugins

## [amq-protocol](http://github.com/ruby-amqp/amq-protocol)

| | |
|---|---|
| **Version** | 2.5.1 |
| **Authors** | Jakub Stastny, Michael S. Klishin, Theo Hultberg, Mark Abramov |
| **License** | MIT |
| **Ruby** | >= 2.2 |

AMQP 0.9.1 encoding & decoding library.

amq-protocol is an AMQP 0.9.1 serialization library for Ruby. It is not a client: the library only handles serialization and deserialization.

## [anbt-sql-formatter](https://github.com/sonota88/anbt-sql-formatter)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | sonota88 |

A tool for SQL formatting written in Ruby.

A tool for SQL formatting written in Ruby. Ruby port of Blanco SQL Formatter.

## [annotate](http://github.com/ctran/annotate_models)

| | |
|---|---|
| **Version** | 2.7.5 |
| **Authors** | Alex Chaffee, Cuong Tran, Marcos Piccinini, Turadg Aleahmad, Jon Frisby |
| **License** | Ruby |
| **Ruby** | >= 2.2.0 |

Annotates Rails Models, routes, fixtures, and others based on the database schema.

Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.

**Dependencies:** rake (>= 10.4, < 13.0), activerecord (>= 3.2, < 7.0)

## [annotaterb](https://github.com/drwl/annotaterb)

| | |
|---|---|
| **Version** | 4.21.0 |
| **Authors** | Andrew W. Lee |
| **License** | BSD-2-Clause |
| **Ruby** | >= 3.0.0 |

A gem for generating annotations for Rails projects.

Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.

**Dependencies:** activerecord (>= 6.0.0), activesupport (>= 6.0.0)

## [ansi](http://rubyworks.github.com/ansi)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Thomas Sawyer, Florian Frank |
| **License** | BSD-2-Clause |

ANSI at your fingertips!

The ANSI project is a superlative collection of ANSI escape code related libraries eabling ANSI colorization and stylization of console output. Byte for byte ANSI is the best ANSI code library available for the Ruby programming language.

## [anthropic](https://github.com/alexrudall/anthropic)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Alex |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Anthropic API + Ruby! 🤖🌌

**Dependencies:** event_stream_parser (>= 0.3.0, < 2.0.0), faraday (>= 1), faraday-multipart (>= 1)

## [any_login](https://github.com/igorkasyanchuk)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Igor Kasyanchuk |
| **License** | MIT |
| **Ruby** | >= 3.0 |

AnyLogin is created to speedup development process and allow developer's quickly login as any user in DB.

Simply add this gem to your application and make your life easier with switching users.

**Dependencies:** rails (>= 6.1)

## [anycable](http://github.com/anycable/anycable-rb)

| | |
|---|---|
| **Version** | 1.6.2 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |

Ruby SDK for AnyCable, an open-source realtime server for reliable two-way communication

**Dependencies:** anycable-core (= 1.6.2), grpc (~> 1.6)

## [anycable-core](http://github.com/anycable/anycable-rb)

| | |
|---|---|
| **Version** | 1.6.2 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Ruby SDK for AnyCable, an open-source realtime server for reliable two-way communication

**Dependencies:** anyway_config (~> 2.2), base64 (>= 0.2), google-protobuf (~> 4), stringio (~> 3)

## [anycable-rails](http://github.com/anycable/anycable-rails)

| | |
|---|---|
| **Version** | 1.6.1 |
| **Authors** | palkan |
| **License** | MIT |

AnyCable integration for Rails

**Dependencies:** anycable-rails-core (= 1.6.1), anycable (>= 0)

## [anycable-rails-core](http://github.com/anycable/anycable-rails)

| | |
|---|---|
| **Version** | 1.6.1 |
| **Authors** | palkan |
| **License** | MIT |
| **Ruby** | >= 2.7 |

AnyCable integration for Rails (w/o RPC dependencies)

**Dependencies:** anycable-core (~> 1.6.0), actioncable (>= 7.0, < 9.0), globalid (>= 0)

## [anyway_config](http://github.com/palkan/anyway_config)

| | |
|---|---|
| **Version** | 2.8.0 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Configuration DSL for Ruby libraries and applications

Configuration DSL for Ruby libraries and applications. Allows you to easily follow the twelve-factor application principles (https://12factor.net/config).

**Dependencies:** ruby-next-core (~> 1.0)

## [apexcharts](https://github.com/styd/apexcharts.rb)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Adrian Setyadi |
| **License** | MIT |

Awesome charts for your ruby app

Create beautiful, interactive, and responsive web charts in ruby app powered by apexcharts.js.

## [api_key_manager](https://github.com/MadBomber/api_key_manager)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Manage one or more API keys to the same resource that is rate limited.

## [apnotic](http://github.com/ostinelli/apnotic)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Roberto Ostinelli |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Apnotic is an Apple Push Notification gem able to provide instant feedback.

**Dependencies:** net-http2 (>= 0.18.3, < 2), connection_pool (>= 2, < 4), base64 (>= 0)

## [apple_id](https://github.com/nov/apple_id)

| | |
|---|---|
| **Version** | 1.6.4 |
| **Authors** | nov |
| **License** | MIT |

Sign-in with Apple Backend

Sign-in with Apple backend library in Ruby.

**Dependencies:** json-jwt (~> 1.16), rack-oauth2 (~> 2.0), openid_connect (~> 2.2)

## [appraisal](http://github.com/thoughtbot/appraisal)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Joe Ferris, Prem Sichanugrist |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Find out what your Ruby gems are worth

Appraisal integrates with bundler and rake to test your library against different versions of dependencies in repeatable scenarios called "appraisals."

**Dependencies:** rake (>= 0), bundler (>= 0), thor (>= 0.14.0)

## [ar_lazy_preload](https://github.com/DmitryTsepelev/ar_lazy_preload)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | DmitryTsepelev |
| **License** | MIT |
| **Ruby** | >= 2.6 |

lazy_preload implementation for ActiveRecord models

**Dependencies:** rails (>= 5.2)

## [arel](http://github.com/rails/arel)

| | |
|---|---|
| **Version** | 3.0.3 |
| **Authors** | Aaron Patterson, Bryan Halmkamp, Emilio Tagua, Nick Kallen |
| **License** | MIT |

Arel is a SQL AST manager for Ruby

Arel is a SQL AST manager for Ruby. It  1. Simplifies the generation of complex SQL queries 2. Adapts to various RDBMS systems  It is intended to be a framework framework; that is, you can build your own ORM with it, focusing on innovative object and collection modeling as opposed to database compatibility and query generation.

## [array_include_methods](http://github.com/AndyObtiva/array_include_methods)

| | |
|---|---|
| **Version** | 1.5.1 |
| **Authors** | Andy Maleh |
| **License** | MIT |

Array#include_all?, Array#include_any?, and other methods missing from basic Ruby Array API

Array#include_all?, Array#include_any?, Array#include_array?, Array#array_index, Array#counts, and Array#duplicates methods missing from basic Ruby Array API. Compatible with Ruby, JRuby, Opal, and RubyMotion.

## [arrayfields](https://github.com/ahoward/arrayfields)

| | |
|---|---|
| **Version** | 4.9.2 |
| **Authors** | Ara T. Howard |
| **License** | same as ruby's |

arrayfields

string/symbol keyword access to arrays

## [artii](http://github.com/miketierney/artii)

| | |
|---|---|
| **Version** | 2.1.2 |
| **Authors** | Mike Tierney |
| **License** | MIT |

A little Figlet-based ASCII art generator.

A Figlet-based ASCII art generator, useful for comand-line based ASCII Art Generation.

## [ascii85_native](https://github.com/AnomalousBit/ascii85_native)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Jason Crossfield |
| **License** | MIT |

Ascii85 Encoder / Decoder with Native C Extensions

A faster implementation of the Ascii85 Encode & Decode methods using native C extensions to do the heavy lifting.

**Dependencies:** ffi (~> 1.15, >= 1.15.0)

## [asciidoctor](https://asciidoctor.org)

| | |
|---|---|
| **Version** | 2.0.26 |
| **Authors** | Dan Allen, Sarah White, Ryan Waldron, Jason Porter, Nick Hengeveld, Jeremy McAnally |
| **License** | MIT |

An implementation of the AsciiDoc text processor and publishing toolchain

A fast, open source text processor and publishing toolchain for converting AsciiDoc content to HTML 5, DocBook 5, and other formats.

## [ast](https://whitequark.github.io/ast/)

| | |
|---|---|
| **Version** | 2.4.3 |
| **Authors** | whitequark |
| **License** | MIT |

A library for working with Abstract Syntax Trees.

## [astronoby](https://github.com/rhannequin/astronoby)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Rémy Hannequin |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Astronomical calculations

Astronomy and astrometry Ruby library for astronomical data and events.

**Dependencies:** ephem (~> 0.3), matrix (~> 0.4.2)

## [async](https://github.com/socketry/async)

| | |
|---|---|
| **Version** | 2.12.1 |
| **Authors** | Samuel Williams, Bruno Sutic, Jeremy Jung, Olle Jonsson, Devin Christensen, Emil Tin, Kent Gruber, Brian Morearty, Colin Kelley, Dimitar Peychinov, Gert Goet, Jiang Jinyang, Julien Portalier, Jun Jiang, Ken Muryoi, Leon Löchner, Masafumi Okura, Masayuki Yamamoto, Math Ieu, Patrik Wenger, Ryan Musgrave, Salim Semaoune, Shannon Skipper, Sokolov Yura, Stefan Wrobel, Trevor Turk |
| **License** | MIT |
| **Ruby** | >= 3.1.1 |

A concurrency framework for Ruby.

**Dependencies:** console (~> 1.25, >= 1.25.2), fiber-annotation (>= 0), io-event (~> 1.6, >= 1.6.5)

## [async-cable](https://rubygems.org/gems/async-cable)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

An asynchronous adapter for ActionCable.

**Dependencies:** actioncable-next (>= 0), async (~> 2.9), async-websocket (>= 0)

## [async-container](https://github.com/socketry/async-container)

| | |
|---|---|
| **Version** | 0.30.0 |
| **Authors** | Samuel Williams, Olle Jonsson, Anton Sozontov, Juan Antonio Martín Lucas, Marc-André Cournoyer, Yuji Yaginuma |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Abstract container-based parallelism using threads and processes where appropriate.

**Dependencies:** async (~> 2.22)

## [async-container-supervisor](https://github.com/socketry/async-container-supervisor)

| | |
|---|---|
| **Version** | 0.9.3 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A supervisor for managing multiple container processes.

**Dependencies:** async-service (>= 0), io-endpoint (>= 0), memory (~> 0.7), memory-leak (~> 0.5), process-metrics (>= 0)

## [async-http](https://github.com/socketry/async-http)

| | |
|---|---|
| **Version** | 0.94.2 |
| **Authors** | Samuel Williams, Brian Morearty, Bruno Sutic, Janko Marohnić, Thomas Morgan, Adam Daniels, Igor Sidorov, William T. Nelson, Anton Zhuravsky, Cyril Roelandt, Denis Talakevich, Hal Brodigan, Ian Ker-Seymer, Jean Boussier, Josh Huber, Marco Concetto Rudilosso, Olle Jonsson, Orgad Shaneh, Sam Shadwell, Stefan Wrobel, Tim Meusel, Trevor Turk, Viacheslav Koval, Yuuji Yaginuma, dependabot[bot] |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A HTTP client and server library.

**Dependencies:** async (>= 2.10.2), async-pool (~> 0.11), io-endpoint (~> 0.14), io-stream (~> 0.6), metrics (~> 0.12), protocol-http (~> 0.58), protocol-http1 (~> 0.36), protocol-http2 (~> 0.22), protocol-url (~> 0.2), traces (~> 0.10)

## [async-http-cache](https://github.com/socketry/async-http-cache)

| | |
|---|---|
| **Version** | 0.4.6 |
| **Authors** | Samuel Williams, Colin Kelley, Olle Jonsson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Standard-compliant cache for async-http.

**Dependencies:** async-http (~> 0.56)

## [async-http-faraday](https://github.com/socketry/async-http-faraday)

| | |
|---|---|
| **Version** | 0.22.1 |
| **Authors** | Samuel Williams, Igor Sidorov, Andreas Garnaes, Genki Takiuchi, Nikolaos Anastopoulos, Olle Jonsson, Benoit Daloze, Denis Talakevich, Flavio Fernandes, Jacob Frautschi, Pedro Fayolle |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provides an adaptor between async-http and faraday.

**Dependencies:** async-http (~> 0.42), faraday (>= 0)

## [async-io](https://github.com/socketry/async-io)

| | |
|---|---|
| **Version** | 1.43.2 |
| **Authors** | Samuel Williams, Olle Jonsson, Benoit Daloze, Thibaut Girka, Hal Brodigan, Janko Marohnić, Aurora Nockert, Bruno Sutic, Cyril Roelandt, Hasan Kumar, Jiang Jinyang, Maruth Goyal, Patrik Wenger |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Provides support for asynchonous TCP, UDP, UNIX and SSL sockets.

**Dependencies:** async (>= 0)

## [async-job](https://rubygems.org/gems/async-job)

| | |
|---|---|
| **Version** | 0.11.1 |
| **Authors** | Samuel Williams, Shopify Inc., Alexey Ivanov, Garen Torikian, Luiz Carlos |
| **License** | MIT |
| **Ruby** | >= 3.2 |

An asynchronous job queue for Ruby.

**Dependencies:** async (~> 2.9), string-format (~> 0.2)

## [async-job-adapter-active_job](https://github.com/socketry/async-job-adapter-active_job)

| | |
|---|---|
| **Version** | 0.18.3 |
| **Authors** | Samuel Williams, Paul Shippy, Trevor Turk |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A asynchronous job queue for Ruby on Rails.

**Dependencies:** async-job (~> 0.9), async-service (~> 0.12)

## [async-job-processor-redis](https://rubygems.org/gems/async-job-processor-redis)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A asynchronous job queue for Ruby.

**Dependencies:** async-job (~> 0.10), async-redis (>= 0)

## [async-pool](https://github.com/socketry/async-pool)

| | |
|---|---|
| **Version** | 0.11.1 |
| **Authors** | Samuel Williams, Jean Boussier, Olle Jonsson, Simon Perepelitsa, Thomas Morgan |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A singleplex and multiplex resource pool for implementing robust clients.

**Dependencies:** async (>= 2.0)

## [async-redis](https://github.com/socketry/async-redis)

| | |
|---|---|
| **Version** | 0.13.1 |
| **Authors** | Samuel Williams, Huba Nagy, David Ortiz, Joan Lledó, Gleb Sinyavskiy, Mikael Henriksson, Travis Bell, Troex Nevelin, Alex Matchneer, Jeremy Jung, Olle Jonsson, Pierre Montelle, Salim Semaoune, Tim Willard |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A Redis client library.

**Dependencies:** async (~> 2.10), async-pool (~> 0.2), io-endpoint (~> 0.10), io-stream (~> 0.4), protocol-redis (~> 0.11)

## [async-service](https://github.com/socketry/async-service)

| | |
|---|---|
| **Version** | 0.18.1 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A service layer for Async.

**Dependencies:** async (>= 0), async-container (~> 0.29), string-format (~> 0.2)

## [async-websocket](https://github.com/socketry/async-websocket)

| | |
|---|---|
| **Version** | 0.30.0 |
| **Authors** | Samuel Williams, Simon Crocker, Olle Jonsson, Thomas Morgan, Aurora Nockert, Bryan Powell, Emily Love Mills, Gleb Sinyavskiy, Janko Marohnić, Juan Antonio Martín Lucas, Michel Boaventura, Peter Runich, Ryu Sato |
| **License** | MIT |
| **Ruby** | >= 3.1 |

An async websocket library on top of protocol-websocket.

**Dependencies:** async-http (~> 0.76), protocol-http (~> 0.34), protocol-rack (~> 0.7), protocol-websocket (~> 0.17)

## [atlassian-jwt](https://bitbucket.org/atlassian/atlassian-jwt-ruby)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Spike Ilacqua, Seb Ruiz, Ngoc Dao |
| **License** | Apache 2.0 |

Encode and decode JWT tokens for use with the Atlassian Connect REST APIs.

This gem simplifies generating the claims needed to authenticate with the Atlassian Connect REST APIs.

**Dependencies:** jwt (~> 2.1)

## [attr_encrypted](http://github.com/attr-encrypted/attr_encrypted)

| | |
|---|---|
| **Version** | 4.2.0 |
| **Authors** | Sean Huber, S. Brent Faulkner, William Monk, Stephen Aghaulor, Josh Branham, Mike Vastola |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Encrypt and decrypt attributes

Generates attr_accessors that encrypt and decrypt attributes transparently

**Dependencies:** encryptor (~> 3.0.0)

## [attr_extras](https://github.com/barsoom/attr_extras)

| | |
|---|---|
| **Version** | 7.1.0 |
| **Authors** | Henrik Nyh, Joakim Kolsjö, Tomas Skogberg, Victor Arias, Ola K |
| **License** | MIT |

Takes some boilerplate out of Ruby with methods like attr_initialize.

## [attr_json](https://github.com/jrochkind/attr_json)

| | |
|---|---|
| **Version** | 2.6.0 |
| **Authors** | Jonathan Rochkind |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

ActiveRecord attributes stored serialized in a json column, super smooth.

ActiveRecord attributes stored serialized in a json column, super smooth. Typed and cast like Active Record. Supporting nested models, dirty tracking, some querying (with postgres jsonb contains), and working smoothy with form builders.  Use your database as a typed object store via ActiveRecord, in the same models right next to ordinary ActiveRecord column-backed attributes and associations. Your json-serialized attr_json attributes use as much of the existing ActiveRecord architecture as we can.

**Dependencies:** activerecord (>= 6.0.0, < 8.2)

## [attr_required](https://github.com/nov/attr_required)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | nov matake |
| **License** | MIT |

attr_required and attr_optional

## [attractor](https://github.com/julianrubisch/attractor)

| | |
|---|---|
| **Version** | 2.6.0 |
| **Authors** | Julian Rubisch |
| **License** | MIT |

Churn vs Complexity Chart Generator

Many authors (Michael Feathers, Sandi Metz) have shown that an evaluation of churn vs complexity of files in software projects provide a valuable metric towards code quality. This is another take on the matter, for ruby code, using the `churn` and `flog` projects.

**Dependencies:** churn (>= 1.0.4), descriptive_statistics (>= 0), flog (~> 4.0), launchy (>= 0), listen (~> 3.0), rack-livereload (>= 0), sinatra (>= 0), thor (>= 0), tilt (>= 0)

## [audited](https://github.com/collectiveidea/audited)

| | |
|---|---|
| **Version** | 5.8.0 |
| **Authors** | Brandon Keepers, Kenneth Kalmer, Daniel Morrison, Brian Ryckbost, Steve Richert, Ryan Glover |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Log all changes to your models

**Dependencies:** activerecord (>= 5.2, < 8.2), activesupport (>= 5.2, < 8.2)

## [auto_html](https://github.com/dejan/auto_html)

| | |
|---|---|
| **Version** | 2.2.1 |
| **Authors** | Dejan Simic |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Plain text to HTML conversion

Collection of filters for transforming text into HTML code

**Dependencies:** gemoji (~> 4.0.0.rc2), redcarpet (~> 3.5), rexml (~> 3.3.9), rinku (~> 2.0)

## [autotuner](https://github.com/Shopify/autotuner)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Peter Zhu |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Get suggestions to tune Ruby's garbage collector

## [avo](https://avohq.io)

| | |
|---|---|
| **Version** | 3.29.0 |
| **Authors** | Adrian Marin, Mihai Marin, Paul Bob |
| **License** | LGPL-3.0, Commercial |
| **Ruby** | >= 3.0.0 |

Admin panel framework and Content Management System for Ruby on Rails.

Avo is a very custom Content Management System for Ruby on Rails that saves engineers and teams months of development time by building user interfaces and logic using configuration rather than traditional coding; When configuration is not enough, you can fallback to familiar Ruby on Rails code.

**Dependencies:** activerecord (>= 6.1), activesupport (>= 6.1), actionview (>= 6.1), pagy (>= 7.0.0, < 43), zeitwerk (>= 2.6.12), active_link_to (>= 0), view_component (>= 3.7.0), turbo-rails (>= 2.0.0), turbo_power (>= 0.6.0), addressable (>= 0), meta-tags (>= 0), docile (>= 0), prop_initializer (>= 0.2.0), avo-icons (>= 0.1.1)

## [avo-heroicons](https://avohq.io)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Paul Bob, Adrian Marin |

A lightweight Avo dependency for serving Heroicons SVGs effortlessly.

## [avo-icons](https://avohq.io)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Paul Bob, Adrian Marin |

A lightweight gem for serving icon SVGs effortlessly in Rails applications.

A standalone Rails gem that provides Heroicons and Tabler Icons with smart caching and configurable search paths. Works with any Rails application.

**Dependencies:** inline_svg (>= 0)

## [awesome_nested_set](https://github.com/collectiveidea/awesome_nested_set)

| | |
|---|---|
| **Version** | 3.9.0 |
| **Authors** | Brandon Keepers, Daniel Morrison, Philip Arndt |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

An awesome nested set implementation for Active Record

**Dependencies:** activerecord (>= 4.0.0, < 8.2)

## [awesome_print](https://github.com/awesome-print/awesome_print)

| | |
|---|---|
| **Version** | 1.9.2 |
| **Authors** | Michael Dvorkin |
| **License** | MIT |

Pretty print Ruby objects with proper indentation and colors

Great Ruby debugging companion: pretty print Ruby objects to visualize their structure. Supports custom object formatting via plugins

## [aws-eventstream](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS Event Stream Library

Amazon Web Services event stream library. Decodes and encodes binary stream under `vnd.amazon.event-stream` content-type

## [aws-partitions](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.1213.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

Provides information about AWS partitions, regions, and services.

Provides interfaces to enumerate AWS partitions, regions, and services.

## [aws-s3](http://amazon.rubyforge.org)

| | |
|---|---|
| **Version** | 0.6.3 |
| **Authors** | Marcel Molina Jr. |

Client library for Amazon's Simple Storage Service's REST API

**Dependencies:** xml-simple (>= 0), builder (>= 0), mime-types (>= 0)

## [aws-sdk-bedrock](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.74.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS SDK for Ruby - Amazon Bedrock

Official AWS Ruby gem for Amazon Bedrock. This gem is part of the AWS SDK for Ruby.

**Dependencies:** aws-sdk-core (~> 3, >= 3.241.4), aws-sigv4 (~> 1.5)

## [aws-sdk-bedrockruntime](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.73.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS SDK for Ruby - Amazon Bedrock Runtime

Official AWS Ruby gem for Amazon Bedrock Runtime. This gem is part of the AWS SDK for Ruby.

**Dependencies:** aws-sdk-core (~> 3, >= 3.241.4), aws-sigv4 (~> 1.5)

## [aws-sdk-core](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 3.242.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS SDK for Ruby - Core

Provides API clients for AWS. This gem is part of the official AWS SDK for Ruby.

**Dependencies:** aws-eventstream (~> 1, >= 1.3.0), aws-partitions (~> 1, >= 1.992.0), aws-sigv4 (~> 1.9), base64 (>= 0), bigdecimal (>= 0), jmespath (~> 1, >= 1.6.1), logger (>= 0)

## [aws-sdk-http-async](https://github.com/thomaswitt/aws-sdk-http-async)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Thomas Witt |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.4.0 |

Async HTTP handler plugin for AWS SDK for Ruby

Provides an async-http based send handler for aws-sdk-core.

**Dependencies:** aws-sdk-core (>= 3.241.0), async-http (>= 0.94.0)

## [aws-sdk-kms](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.121.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS SDK for Ruby - KMS

Official AWS Ruby gem for AWS Key Management Service (KMS). This gem is part of the AWS SDK for Ruby.

**Dependencies:** aws-sdk-core (~> 3, >= 3.241.4), aws-sigv4 (~> 1.5)

## [aws-sdk-s3](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.213.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS SDK for Ruby - Amazon S3

Official AWS Ruby gem for Amazon Simple Storage Service (Amazon S3). This gem is part of the AWS SDK for Ruby.

**Dependencies:** aws-sdk-kms (~> 1), aws-sigv4 (~> 1.5), aws-sdk-core (~> 3, >= 3.241.4)

## [aws-sdk-sqs](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.111.0 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS SDK for Ruby - Amazon SQS

Official AWS Ruby gem for Amazon Simple Queue Service (Amazon SQS). This gem is part of the AWS SDK for Ruby.

**Dependencies:** aws-sdk-core (~> 3, >= 3.241.4), aws-sigv4 (~> 1.5)

## [aws-sigv4](https://github.com/aws/aws-sdk-ruby)

| | |
|---|---|
| **Version** | 1.12.1 |
| **Authors** | Amazon Web Services |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

AWS Signature Version 4 library.

Amazon Web Services Signature Version 4 signing library. Generates sigv4 signature for HTTP requests.

**Dependencies:** aws-eventstream (~> 1, >= 1.0.2)

## [axiom-types](https://github.com/dkubb/axiom-types)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Dan Kubb |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Abstract types for logic programming

Define types with optional constraints for use within axiom and other libraries.

**Dependencies:** descendants_tracker (~> 0.0.4), ice_nine (~> 0.11.0), thread_safe (~> 0.3, >= 0.3.1)

## [babosa](http://github.com/norman/babosa)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Norman Clarke |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A library for creating slugs.

A library for creating slugs. Babosa an extraction and improvement of the string code from FriendlyId, intended to help developers create similar libraries or plugins.

## [backport](http://github.com/castwide/backport)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Fred Snyder |
| **License** | MIT |
| **Ruby** | >= 2.1 |

A pure Ruby library for event-driven IO

## [backports](http://github.com/marcandre/backports)

| | |
|---|---|
| **Version** | 3.25.3 |
| **Authors** | Marc-André Lafortune |
| **License** | MIT |

Backports of Ruby features for older Ruby.

Essential backports that enable many of the nice features of Ruby for earlier versions.

## [bake](https://github.com/ioquatix/bake)

| | |
|---|---|
| **Version** | 0.24.1 |
| **Authors** | Samuel Williams, Olle Jonsson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A replacement for rake with a simpler syntax.

**Dependencies:** bigdecimal (>= 0), samovar (~> 2.1)

## [baran](https://github.com/moekidev/baran)

| | |
|---|---|
| **Version** | 0.1.12 |
| **Authors** | Moeki Kawakami |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Text Splitter for Large Language Model Datasets

Text Splitter for Large Language Model Datasets.

## [base32](https://rubygems.org/gems/base32)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Samuel Tesla |
| **License** | MIT |

Ruby extension for base32 encoding and decoding

## [base64](https://github.com/ruby/base64)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Yusuke Endoh |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.4 |

Support for encoding and decoding binary data using a Base64 representation.

## [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)

| | |
|---|---|
| **Version** | 3.1.21 |
| **Authors** | Coda Hale |
| **License** | MIT |

OpenBSD's bcrypt() password hashing algorithm.

bcrypt() is a sophisticated and secure hash algorithm designed by The OpenBSD project for hashing passwords. The bcrypt Ruby gem provides a simple wrapper for safely handling passwords.

## [bcrypt_pbkdf](https://github.com/net-ssh/bcrypt_pbkdf-ruby)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Miklos Fazekas |
| **License** | MIT |

OpenBSD's bcrypt_pbkdf (a variant of PBKDF2 with bcrypt-based PRF)

This gem implements bcrypt_pbkdf (a variant of PBKDF2 with bcrypt-based PRF)

## [benchmark](https://github.com/ruby/benchmark)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.1.0 |

a performance benchmarking library

## [benchmark-ips](https://github.com/evanphx/benchmark-ips)

| | |
|---|---|
| **Version** | 2.14.0 |
| **Authors** | Evan Phoenix |
| **License** | MIT |

A iterations per second enhancement to Benchmark.

## [benry-cmdopt](https://kwatch.github.io/benry-ruby/benry-cmdopt.html)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | kwatch |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Command option parser, much better than `optparse.rb`

Command option parser, much simpler and better than `optparse.rb`.  Why not `optparse.rb`? See https://kwatch.github.io/benry-ruby/benry-cmdopt.html#why-not-optparserb for details.

## [benry-recorder](https://github.com/kwatch/benry-ruby/tree/ruby/benry-recorder)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | kwatch |
| **License** | MIT |

Record method calls, or define fake methods.

Benry-recorder is a tiny utility that can:  * Record method calls of target object. * Define fake methods on target object. * Create fake object which has fake methods.

## [better_html](https://github.com/Shopify/better-html)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Francois Chagnon |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Better HTML for Rails.

Better HTML for Rails. Provides sane html helpers that make it easier to do the right thing.

**Dependencies:** actionview (>= 7.0), activesupport (>= 7.0), ast (~> 2.0), erubi (~> 1.4), parser (>= 2.4), smart_properties (>= 0)

## [bible_gateway](https://github.com/gdagley/bible_gateway)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Geoffrey Dagley |
| **License** | MIT |

An unofficial 'API' for BibleGateway.com and the classic BibleGateway

An unofficial 'API' for BibleGateway.com.

**Dependencies:** nokogiri (>= 0), typhoeus (>= 0)

## [bidi2pdf](https://github.com/dieter-medium/bidi2pdf)

| | |
|---|---|
| **Version** | 0.1.12 |
| **Authors** | Dieter S. |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

A Ruby gem that generates PDFs from web pages using Chrome's BiDi protocol, providing high-quality PDF documents from any URL with full support for modern web features.

Bidi2pdf is a powerful PDF generation tool that uses Chrome's BiDirectional Protocol to render web pages as high-quality PDF documents. It offers:  * Command-line interface for easy PDF generation * Support for cookies, headers, and basic authentication * Waiting conditions (window loaded, network idle) * Headless Chrome operation for server environments * Docker compatibility * Customizable PDF output options  Bidi2pdf uses ChromeDriver to control Chrome through its BiDi protocol, providing precise rendering for reports, invoices, documentation, and other PDF documents from web-based content. It automatically manages the ChromeDriver binary and browser sessions for a seamless experience.

**Dependencies:** base64 (>= 0.2, < 0.4), chromedriver-binary (>= 0), concurrent-ruby (~> 1.0, >= 1.3.1), json (~> 2.10), rubyzip (~> 2.4), sys-proctable (~> 1.3), thor (~> 1.3), websocket-client-simple (~> 0.9.0)

## [bigdecimal](https://github.com/ruby/bigdecimal)

| | |
|---|---|
| **Version** | 3.3.1 |
| **Authors** | Kenta Murata, Zachary Scott, Shigeo Kobayashi |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Arbitrary-precision decimal floating-point number library.

This library provides arbitrary-precision decimal floating-point number class.

## [bin](http://github.com/jnunemaker/bin)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | John Nunemaker |

ActiveSupport MongoDB Cache store.

**Dependencies:** mongo (~> 1.3.0), activesupport (>= 3.0.0, < 3.2.0)

## [bindata](https://github.com/dmendel/bindata)

| | |
|---|---|
| **Version** | 2.5.1 |
| **Authors** | Dion Mendel |
| **License** | BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

A declarative way to read and write binary file formats

BinData is a declarative way to read and write binary file formats.  This means the programmer specifies *what* the format of the binary data is, and BinData works out *how* to read and write data in this format.  It is an easier ( and more readable ) alternative to ruby's #pack and #unpack methods.

## [bindex](https://github.com/gsamokovarov/bindex)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Genadi Samokovarov |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Bindings for your Ruby exceptions

## [binding.repl](https://github.com/rpag/binding.repl)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | rpag |
| **License** | MIT |

"binding.pry" for every ruby repl

## [binding_of_caller](https://github.com/banister/binding_of_caller)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | John Mair (banisterfiend) |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Retrieve the binding of a method's caller, or further up the stack.

Provides the Binding#of_caller method.  Using binding_of_caller we can grab bindings from higher up the call stack and evaluate code in that context. Allows access to bindings arbitrarily far up the call stack, not limited to just the immediate caller.  Recommended for use only in debugging situations. Do not use this in production apps.

**Dependencies:** debug_inspector (>= 1.2.0)

## [bitwise](http://github.com/kenn/bitwise)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Kenn Ejima |

Fast, memory efficient bitwise operations on large binary strings

## [blazer](https://github.com/ankane/blazer)

| | |
|---|---|
| **Version** | 3.3.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Explore your data with SQL. Easily create charts and dashboards, and share them with your team.

**Dependencies:** railties (>= 7.1), activerecord (>= 7.1), chartkick (>= 5), safely_block (>= 0.4), csv (>= 0)

## [blazer-ai](https://github.com/kieranklaassen/blazer-ai)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Kieran Klaassen |
| **License** | MIT |
| **Ruby** | >= 3.2 |

AI-powered SQL generation for Blazer

A Rails engine that adds AI-powered natural language to SQL generation for the Blazer analytics dashboard. Uses RubyLLM to support multiple AI providers (OpenAI, Anthropic, Gemini, etc.).

**Dependencies:** rails (>= 7.1), blazer (>= 3.0), ruby_llm (>= 1.0)

## [blueprinter](https://github.com/procore-oss/blueprinter)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Procore Technologies, Inc. |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Simple Fast Declarative Serialization Library

Blueprinter is a JSON Object Presenter for Ruby that takes business objects and breaks them down into simple hashes and serializes them to JSON. It can be used in Rails in place of other serializers (like JBuilder or ActiveModelSerializers). It is designed to be simple, direct, and performant.

## [bmg](http://github.com/enspirit/bmg)

| | |
|---|---|
| **Version** | 0.23.6 |
| **Authors** | Bernard Lambeau |
| **License** | MIT |

Bmg is Alf's successor.

Bmg is Alf's relational algebra for ruby, but much simpler and lighter than Alf itself

**Dependencies:** predicate (>= 2.7.1, < 3.0), path (>= 2.0)

## [bond](http://tagaholic.me/bond/)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Gabriel Horner |
| **License** | MIT |

Mission: Easy custom autocompletion for arguments, methods and beyond. Accomplished for irb and any other readline-like console environments.

Bond is on a mission to improve autocompletion in ruby, especially for irb/ripl. Aside from doing everything irb's can do and fixing its quirks, Bond can autocomplete argument(s) to methods, uniquely completing per module, per method and per argument. Bond brings ruby autocompletion closer to bash/zsh as it provides a configuration system and a DSL for creating custom completions and completion rules. With this configuration system, users can customize their autocompletions and share it with others. Bond can also load completions that ship with gems.  Bond is able to offer more than irb's completion since it uses the full line of input when completing as opposed to irb's last-word approach.

## [bootsnap](https://github.com/rails/bootsnap)

| | |
|---|---|
| **Version** | 1.22.0 |
| **Authors** | Burke Libbey |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Boot large ruby/rails apps faster

**Dependencies:** msgpack (~> 1.2)

## [boson](http://tagaholic.me/boson/)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Gabriel Horner |
| **License** | MIT |

A command/task framework similar to rake and thor that opens your ruby universe to the commandline and irb.

Boson is a modular command/task framework. Thanks to its rich set of plugins, it differentiates itself from rake and thor by being usable from irb and the commandline, having optional automated views generated by hirb and allowing libraries to be written as plain ruby. Works with ruby >= 1.9.2

## [boson-more](http://github.com/cldwalker/boson-more)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Gabriel Horner |
| **License** | MIT |

boson2 plugins

A collection of boson plugins that can be mixed and matched

**Dependencies:** boson (>= 1.3.0)

## [botrytis](https://github.com/sublayerapp/botrytis)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Scott Werner |
| **Ruby** | >= 3.1.0 |

LLM-powered fuzzy matching for your cucumber steps

Botrytis provides semantic matching for Cucumber step definitions using LLMs

**Dependencies:** cucumber (>= 9), sublayer (>= 0.2.8)

## [boxcars](https://github.com/BoxcarsAI/boxcars)

| | |
|---|---|
| **Version** | 0.8.10 |
| **Authors** | Francis Sullivan, Tabrez Syed |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Boxcars is a gem that enables you to create new systems with AI composability. Inspired by python langchain.

You simply set an OpenAI key, give a number of Boxcars to a Train, and magic ensues when you run it.

**Dependencies:** faraday-retry (~> 2.0), google_search_results (~> 2.2), gpt4all (~> 0.0.5), hnswlib (~> 0.9), intelligence (>= 0.8), nokogiri (~> 1.18), ruby-anthropic (~> 0.4), ruby-openai (>= 7.3)

## [brakeman](https://brakemanscanner.org)

| | |
|---|---|
| **Version** | 8.0.2 |
| **Authors** | Justin Collins |
| **License** | Brakeman Public Use License |
| **Ruby** | >= 3.2.0 |

Security vulnerability scanner for Ruby on Rails.

Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis.

**Dependencies:** racc (>= 0)

## [breadcrumbs_on_rails](https://simonecarletti.com/code/breadcrumbs_on_rails)

| | |
|---|---|
| **Version** | 4.1.0 |
| **Authors** | Simone Carletti |
| **License** | MIT |
| **Ruby** | >= 2.4 |

A simple Ruby on Rails plugin for creating and managing a breadcrumb navigation

BreadcrumbsOnRails is a simple Ruby on Rails plugin for creating and managing a breadcrumb navigation for a Rails project.

**Dependencies:** railties (>= 5.0)

## [breaker_machines](https://github.com/seuros/breaker_machines)

| | |
|---|---|
| **Version** | 0.10.3 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Circuit breaker implementation for Ruby with a clean DSL and state_machines under the hood

BreakerMachines is a production-ready circuit breaker implementation for Ruby that prevents cascade failures in distributed systems. Built on the battle-tested state_machines gem, it provides a clean DSL, thread-safe operations, multiple storage backends, and comprehensive introspection tools. Unlike other solutions, BreakerMachines prioritizes safety by avoiding dangerous forceful timeouts while supporting fallback chains, jitter, and event callbacks.

**Dependencies:** activesupport (>= 8.0), chrono_machines (~> 0.2), concurrent-ruby (~> 1.3), rb_sys (~> 0.9), state_machines (>= 0.100.4), zeitwerk (~> 2.7)

## [bridgetown](https://www.bridgetownrb.com)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A next-generation, progressive site generator & fullstack framework, powered by Ruby

Bridgetown is a next-generation, progressive site generator & fullstack framework, powered by Ruby

**Dependencies:** bridgetown-builder (= 2.1.1), bridgetown-core (= 2.1.1), bridgetown-foundation (= 2.1.1), bridgetown-paginate (= 2.1.1)

## [bridgetown-builder](https://github.com/bridgetownrb/bridgetown/tree/main/bridgetown-builder)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Bridgetown Team |
| **License** | MIT |

A Bridgetown plugin to provide a sophisticated DSL for writing plugins at a higher level of abstraction.

**Dependencies:** bridgetown-core (= 2.1.1)

## [bridgetown-core](https://www.bridgetownrb.com)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A next-generation, progressive site generator & fullstack framework, powered by Ruby

Bridgetown is a next-generation, progressive site generator & fullstack framework, powered by Ruby

**Dependencies:** addressable (~> 2.4), amazing_print (~> 1.2), base64 (>= 0.3), bigdecimal (>= 3.2), bridgetown-foundation (= 2.1.1), csv (~> 3.2), erubi (~> 1.9), faraday (~> 2.0), faraday-follow_redirects (~> 0.3), freyia (>= 0.5), i18n (~> 1.0), irb (>= 1.14), kramdown (~> 2.1), kramdown-parser-gfm (~> 1.0), liquid (>= 5.0, < 5.5), listen (~> 3.0), rack (>= 3.0), rackup (~> 2.0), rake (>= 13.0), roda (~> 3.46), rouge (>= 3.0, < 5.0), samovar (>= 2.4), securerandom (~> 0.4), serbea (>= 2.4.1), signalize (~> 1.3), streamlined (>= 0.6.0), tilt (~> 2.0), zeitwerk (>= 2.7.3)

## [bridgetown-foundation](https://github.com/bridgetownrb/bridgetown/tree/main/bridgetown-foundation)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Ruby language extensions and other utilities useful for the Bridgetown ecosystem

**Dependencies:** dry-inflector (>= 1.0), hash_with_dot_access (~> 2.0), inclusive (~> 1.0), zeitwerk (~> 2.5)

## [bridgetown-paginate](https://github.com/bridgetownrb/bridgetown/tree/main/bridgetown-paginate)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Bridgetown Team |
| **License** | MIT |

A Bridgetown plugin to add pagination support for posts and collection indices.

**Dependencies:** bridgetown-core (= 2.1.1)

## [brotli](https://github.com/miyucy/brotli)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | miyucy |
| **License** | MIT |

Brotli compressor/decompressor

## [browser](https://github.com/fnando/browser)

| | |
|---|---|
| **Version** | 6.2.0 |
| **Authors** | Nando Vieira |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Do some browser detection with Ruby.

## [brut](https://brutrb.com)

| | |
|---|---|
| **Version** | 0.18.2 |
| **Authors** | David Bryant Copeland |

Web Framework Built around Ruby, Web Standards, Simplicity, and Object-Orientation

An opinionated web framework build on web standards

**Dependencies:** irb (>= 0), ostruct (>= 0), concurrent-ruby (>= 0), i18n (>= 0), nokogiri (>= 0), phlex (>= 0), prism (>= 0), rack-protection (>= 0), rackup (>= 0), semantic_logger (>= 0), sequel (>= 0), sinatra (>= 0), tzinfo (>= 0), tzinfo-data (>= 0), zeitwerk (>= 0), opentelemetry-sdk (>= 0), opentelemetry-exporter-otlp (>= 0), unicode-display_width (>= 0)

## [bson](https://www.mongodb.com/docs/ruby-driver/current/tutorials/bson-v4/)

| | |
|---|---|
| **Version** | 5.2.0 |
| **Authors** | The MongoDB Ruby Team |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.6 |

Ruby implementation of the BSON specification

A fully featured BSON specification implementation in Ruby

## [bubbles](https://github.com/marcoroth/bubbles-ruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

TUI components for Bubble Tea.

Ruby port of Charm's Bubbles. Common UI components for building terminal applications with Bubble Tea.

**Dependencies:** bubbletea (>= 0), harmonica (>= 0), lipgloss (>= 0)

## [bubbletea](https://github.com/marcoroth/bubbletea-ruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2, < 4.1.dev |

Ruby wrapper for Charm's bubbletea. A powerful TUI framework.

Build beautiful, interactive terminal applications using the Elm Architecture in Ruby.

**Dependencies:** lipgloss (~> 0.1)

## [builder](http://onestepback.org)

| | |
|---|---|
| **Version** | 3.0.4 |
| **Authors** | Jim Weirich |
| **License** | MIT |

Builders for MarkUp.

Builder provides a number of builder objects that make creating structured data simple to do.  Currently the following builder objects are supported:  * XML Markup * XML Events

## [bump](https://github.com/gregorym/bump)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Gregory Marcilhacy |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Bump your gem version file

## [bundle_update_interactive](https://github.com/mattbrictson/bundle_update_interactive)

| | |
|---|---|
| **Version** | 0.13.0 |
| **Authors** | Matt Brictson |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Adds an update-interactive command to Bundler

**Dependencies:** bundler (>= 2, < 5), bundler-audit (>= 0.9.1), concurrent-ruby (>= 1.3.4), launchy (>= 2.5.0), pastel (>= 0.8.0), tty-prompt (>= 0.23.1), tty-screen (>= 0.8.2), zeitwerk (~> 2.6)

## [bundler](https://bundler.io)

| | |
|---|---|
| **Version** | 2.7.2 |
| **Authors** | André Arko, Samuel Giddins, Colby Swandale, Hiroshi Shibata, David Rodríguez, Grey Baker, Stephanie Morillo, Chris Morris, James Wen, Tim Moore, André Medeiros, Jessica Lynn Suttles, Terence Lee, Carl Lerche, Yehuda Katz |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

The best way to manage your application's dependencies

Bundler manages an application's dependencies through its entire life, across many machines, systematically and repeatably

## [bundler-audit](https://github.com/rubysec/bundler-audit#readme)

| | |
|---|---|
| **Version** | 0.9.3 |
| **Authors** | Postmodern |
| **License** | GPL-3.0-or-later |
| **Ruby** | >= 2.0.0 |

Patch-level verification for Bundler

bundler-audit provides patch-level verification for Bundled apps.

**Dependencies:** thor (~> 1.0), bundler (>= 1.2.0)

## [bundler-graph](https://github.com/rubygems/bundler-graph)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Hiroshi SHIBATA |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Generates a visual dependency graph for your Gemfile

`graph` generates a PNG file of the current `Gemfile(5)` as a dependency graph.

## [bundler_mcp](https://github.com/subelsky/bundler_mcp)

| | |
|---|---|
| **Version** | 0.2.1.1 |
| **Authors** | Mike Subelsky |
| **License** | MIT |
| **Ruby** | >= 3.2 |

MCP server for searching Ruby bundled gem documentation and metadata

A Model Context Protocol (MCP) server that enables AI agents to query information about gems in a Ruby project's Gemfile, including source code and metadata.

**Dependencies:** bundler (~> 2.6), fast-mcp (~> 1.4)

## [bunny](http://rubybunny.info)

| | |
|---|---|
| **Version** | 2.24.0 |
| **Authors** | Chris Duncan, Eric Lindvall, Jakub Stastny aka botanicus, Michael S. Klishin, Stefan Kaes |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Popular easy to use Ruby client for RabbitMQ

Easy to use, feature complete Ruby client for RabbitMQ 3.9 and later versions.

**Dependencies:** amq-protocol (~> 2.3), sorted_set (~> 1, >= 1.0.2)

## [bunny_farm](https://github.com/MadBomber/bunny_farm)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |

Simple AMQP/JSON background job manager for RabbitMQ

A lightweight Ruby gem for managing background jobs using RabbitMQ. Messages are encapsulated as classes with JSON serialization and routing keys in the format MessageClassName.action for simple, organized job processing.

**Dependencies:** activesupport (>= 0), concurrent-ruby (>= 0), hashie (>= 0), bunny (>= 0)

## [business_days](http://github.com/burke/business_days)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | Burke Libbey |
| **Ruby** | >= 1.8.7 |

Write me.

Write me...

**Dependencies:** activesupport (>= 0)

## [byebug](https://github.com/deivid-rodriguez/byebug)

| | |
|---|---|
| **Version** | 12.0.0 |
| **Authors** | David Rodriguez, Kent Sibilev, Mark Moseley |
| **License** | BSD-2-Clause |
| **Ruby** | >= 3.1.0 |

Ruby fast debugger - base + CLI

Byebug is a Ruby debugger. It's implemented using the TracePoint C API for execution control and the Debug Inspector C API for call stack navigation.  The core component provides support that front-ends can build on. It provides breakpoint handling and bindings for stack frames among other things and it comes with an easy to use command line interface.

## [cafeznik](https://github.com/LemuelCushing/cafeznik)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Lem |
| **License** | MIT |
| **Ruby** | >= 3.3 |

CLI tool for copying files to your clipboard en masse

A CLI tool for copying files to your clipboard en masse, from a local directory or a GitHub repository. Why? So you can feed them into LLMs like a lazy lazy script kiddie.

**Dependencies:** base64 (~> 0.2), clipboard (~> 2.0), concurrent-ruby (~> 1.3), faraday-multipart (~> 1.0), faraday-retry (~> 2.0), memery (~> 1.6), octokit (~> 9.2), thor (~> 1.3), tty-command (~> 0.10), tty-progressbar (~> 0.18)

## [callback_hell](http://github.com/evilmartians/callback_hell)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Yaroslav Markin, Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Analyze Rails models for callbacks and validations

Callback Hell analyzes your Rails application models and provides useful insights on callbacks and validations defined

**Dependencies:** rails (>= 7.0), zeitwerk (>= 0), table_tennis (>= 0)

## [cancancan](https://github.com/CanCanCommunity/cancancan)

| | |
|---|---|
| **Version** | 3.6.1 |
| **Authors** | Alessandro Rodi (Renuo AG), Bryan Rite, Ryan Bates, Richard Wilson |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

Simple authorization solution for Rails.

Simple authorization solution for Rails. All permissions are stored in a single location.

## [capistrano](https://capistranorb.com/)

| | |
|---|---|
| **Version** | 3.20.0 |
| **Authors** | Tom Clements, Lee Hambley |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Capistrano - Welcome to easy deployment with Ruby over SSH

Capistrano is a utility and framework for executing commands in parallel on multiple remote machines, via SSH.

**Dependencies:** airbrussh (>= 1.0.0), i18n (>= 0), rake (>= 10.0.0), sshkit (>= 1.9.0)

## [capybara](https://github.com/teamcapybara/capybara)

| | |
|---|---|
| **Version** | 3.40.0 |
| **Authors** | Thomas Walpole, Jonas Nicklas |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb

Capybara is an integration testing tool for rack based web applications. It simulates how a user would interact with a website

**Dependencies:** addressable (>= 0), matrix (>= 0), mini_mime (>= 0.1.3), nokogiri (~> 1.11), rack (>= 1.6.0), rack-test (>= 0.6.3), regexp_parser (>= 1.5, < 3.0), xpath (~> 3.2)

## [capybara-mechanize](https://github.com/jeroenvandijk/capybara-mechanize)

| | |
|---|---|
| **Version** | 1.13.0 |
| **Authors** | Jeroen van Dijk |
| **Ruby** | >= 2.6.0 |

RackTest driver for Capybara with remote request support

RackTest driver for Capybara, but with remote request support thanks to mechanize

**Dependencies:** capybara (>= 3.0.0, < 4), mechanize (~> 2.8.5)

## [capybara-thruster](https://github.com/evilmartians/capybara-thruster)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Example description

**Dependencies:** capybara (>= 0), childprocess (>= 4.0), puma (>= 0)

## [caracal](https://github.com/trade-informatics/caracal)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Trade Infomatics, John Dugan |
| **License** | MIT |

Fast, professional Microsoft Word (docx) writer for Ruby.

Caracal is a pure Ruby Microsoft Word generation library that produces professional quality MSWord documents (docx) using a simple, HTML-style DSL.

**Dependencies:** nokogiri (~> 1.6), rubyzip (~> 1.1), tilt (>= 1.4)

## [carrot-top](https://github.com/portertech/carrot-top)

| | |
|---|---|
| **Version** | 0.0.7 |
| **Authors** | Sean Porter |

A Ruby library for querying the RabbitMQ Management API

A Ruby library for querying the RabbitMQ Management API, `top` for RabbitMQ.

**Dependencies:** json (>= 0)

## [case_transform](https://github.com/NullVoxPopuli/case_transform)

| | |
|---|---|
| **Version** | 0.2 |
| **Authors** | L. Preston Sego III, Ben Mills |
| **License** | MIT |
| **Ruby** | >= 2.0 |

CaseTransform-0.2

Extraction of the key_transform abilities of ActiveModelSerializers

**Dependencies:** activesupport (>= 0)

## [caxlsx](https://github.com/caxlsx/caxlsx)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Randy Morgan, Jurriaan Pruis |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Excel OOXML (xlsx) with charts, styles, images and autowidth columns.

xlsx spreadsheet generation with charts, images, automated column width, customizable styles and full schema validation. Axlsx helps you create beautiful Office Open XML Spreadsheet documents (Excel, Google Spreadsheets, Numbers, LibreOffice) without having to understand the entire ECMA specification. Check out the README for some examples of how easy it is. Best of all, you can validate your xlsx file before serialization so you know for sure that anything generated is going to load on your client's machine.

**Dependencies:** htmlentities (~> 4.3, >= 4.3.4), marcel (~> 1.0), nokogiri (~> 1.10, >= 1.10.4), rubyzip (>= 1.3.0, < 3)

## [cd](https://github.com/janlelis/cd)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Enhanced cd command for the Ruby console

Enhanced cd command for the Ruby console. Supports changing to previous directory using `-cd` and to the user's home directory with `~cd`.

## [certified](http://github.com/stevegraham/certified)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Stevie Graham |
| **Ruby** | >= 1.8.7 |

Ensure net/https uses OpenSSL::SSL::VERIFY_PEER to verify SSL certificates and provides certificate bundle in case OpenSSL cannot find one

## [cff](https://github.com/citation-file-format/ruby-cff)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Robert Haines, The Ruby Citation File Format Developers |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.6 |

A Ruby library for manipulating CITATION.cff files.

See https://citation-file-format.github.io/ for more info.

**Dependencies:** json_schema (~> 0.20.4), language_list (~> 1.2.1)

## [cgi](https://github.com/ruby/cgi)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Support for the Common Gateway Interface protocol.

## [chaos_to_the_rescue](https://github.com/codenamev/chaos_to_the_rescue)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Valentino Stoll |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Safe-by-default LLM-powered method generation and Rails error rescue suggestions

ChaosToTheRescue uses LLMs to generate missing methods on-the-fly and suggest fixes for Rails exceptions. Features comprehensive security (secret redaction, opt-in behavior, no auto-execution) and is disabled by default for production safety.

**Dependencies:** logger (~> 1.6)

## [character_set](https://github.com/jaynetics/character_set)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Janosch Müller |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

Build, read, write and compare sets of Unicode codepoints.

## [chartkick](https://chartkick.com)

| | |
|---|---|
| **Version** | 5.2.1 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Create beautiful JavaScript charts with one line of Ruby

## [chef-config](https://github.com/chef/chef)

| | |
|---|---|
| **Version** | 19.1.164 |
| **Authors** | Adam Jacob |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.6 |

Chef Infra's default configuration and config loading library

**Dependencies:** chef-utils (= 19.1.164), mixlib-shellout (>= 2.0, < 4.0), mixlib-config (>= 2.2.12, < 4.0), fuzzyurl (>= 0), addressable (>= 0), tomlrb (~> 1.2), racc (>= 0)

## [chef-gyoku](https://github.com/savonrb/chef-gyoku)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Daniel Harrington |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Translates Ruby Hashes to XML

Gyoku translates Ruby Hashes to XML

**Dependencies:** builder (>= 2.1.2), rexml (~> 3.4)

## [chef-utils](https://github.com/chef/chef/tree/main/chef-utils)

| | |
|---|---|
| **Version** | 19.1.164 |
| **Authors** | Chef Software, Inc |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.6 |

Basic utility functions for Core Chef Infra development

**Dependencies:** concurrent-ruby (>= 0)

## [chef-winrm](https://github.com/WinRb/WinRM)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Dan Wanek, Paul Morton, Matt Wrock, Shawn Neal |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Ruby library for Windows Remote Management

**Dependencies:** builder (>= 2.1.2), chef-gyoku (~> 1.5), erubi (~> 1.8), gssapi (~> 1.2), httpclient (~> 2.2, >= 2.2.0.2), logging (>= 1.6.1, < 3.0), nori (~> 2.7), rexml (>= 3.4.2, < 4.0), rubyntlm (~> 0.6.0, >= 0.6.3)

## [chef-winrm-elevated](https://github.com/chef/chef-winrm-elevated)

| | |
|---|---|
| **Version** | 1.2.5 |
| **Authors** | Shawn Neal |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0.0 |

Ruby library for running commands as elevated

Ruby library for running commands via WinRM as elevated through a scheduled task

**Dependencies:** chef-winrm (>= 2.3.11), chef-winrm-fs (>= 1.3.7), erubi (~> 1.8)

## [chef-winrm-fs](http://github.com/WinRb/winrm-fs)

| | |
|---|---|
| **Version** | 1.4.2 |
| **Authors** | Shawn Neal, Matt Wrock |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

WinRM File System

Ruby library for file system operations via Windows Remote Management

**Dependencies:** chef-winrm (~> 2.4), erubi (>= 1.7), logging (>= 1.6.1, < 3.0), rubyzip (~> 2.0), csv (~> 3.3), benchmark (~> 0.5.0)

## [childprocess](https://github.com/enkessler/childprocess)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | Jari Bakken, Eric Kessler, Shane da Silva |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

A simple and reliable solution for controlling external programs running in the background on any Ruby / OS combination.

This gem aims at being a simple and reliable solution for controlling external programs running in the background on any Ruby / OS combination.

**Dependencies:** logger (~> 1.5)

## [choice](http://www.github.com/defunkt/choice)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Grant Austin, Chris Wanstrath |
| **License** | MIT |

Choice is a command line option parser.

Choice is a simple little gem for easily defining and parsing command line options with a friendly DSL.

## [chromate](https://rubygems.org/gems/chromate)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Octaplex |
| **License** | GPLv3 |

A dead-simple terminal coloring utility.

## [chromedriver-binary](https://github.com/dieter-medium/chromedriver-binary)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Dieter S. |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Automatically downloads and installs ChromeDriver binaries.

A Ruby gem that automatically downloads and installs ChromeDriver binaries that match your installed Chrome browser version.

**Dependencies:** rubyzip (~> 2.4)

## [chronic](http://github.com/mojombo/chronic)

| | |
|---|---|
| **Version** | 0.10.2 |
| **Authors** | Tom Preston-Werner, Lee Jarvis |
| **License** | MIT |

Natural language date/time parsing.

Chronic is a natural language date/time parser written in pure Ruby.

## [chrono_machines](https://github.com/seuros/chrono_machines)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

A robust Ruby gem for implementing retry mechanisms with exponential backoff and jitter.

ChronoMachines offers a flexible and configurable solution for handling transient failures in distributed Ruby applications. It provides powerful retry strategies, including exponential backoff and full jitter, along with customizable callbacks for success, retry, and failure events. Define and manage retry policies with a clean DSL for seamless integration.

**Dependencies:** zeitwerk (~> 2.7)

## [chunky_png](https://github.com/wvanbergen/chunky_png/wiki)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Willem van Bergen |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Pure ruby library for read/write, chunk-level access to PNG files

This pure Ruby library can read and write PNG images without depending on an external image library, like RMagick. It tries to be memory efficient and reasonably fast.  It supports reading and writing all PNG variants that are defined in the specification, with one limitation: only 8-bit color depth is supported. It supports all transparency, interlacing and filtering options the PNG specifications allows. It can also read and write textual metadata from PNG files. Low-level read/write access to PNG chunks is also possible.  This library supports simple drawing on the image canvas and simple operations like alpha composition and cropping. Finally, it can import from and export to RMagick for interoperability.  Also, have a look at OilyPNG at https://github.com/wvanbergen/oily_png. OilyPNG is a drop in mixin module that implements some of the ChunkyPNG algorithms in C, which provides a massive speed boost to encoding and decoding.

## [churn](http://github.com/danmayer/churn)

| | |
|---|---|
| **Version** | 1.0.8 |
| **Authors** | Dan Mayer |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Providing additional churn metrics over the original metric_fu churn

High method and class churn has been shown to have increased bug and error rates. This gem helps you know what is changing a lot so you can do additional testing, code review, or refactoring to try to tame the volatile code.

**Dependencies:** main (>= 0), chronic (>= 0.2.3), sexp_processor (~> 4.1), ruby_parser (~> 3.0), hirb (>= 0)

## [cia](https://github.com/grosser/cia)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Michael Grosser |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Audit model events like update/create/delete + attribute changes + group them by transaction, in normalized table layout for easy query access.

**Dependencies:** activerecord (>= 4.2), activesupport (>= 4.2)

## [citrus](http://mjackson.github.io/citrus)

| | |
|---|---|
| **Version** | 3.0.2 |
| **Authors** | Michael Jackson |

Parsing Expressions for Ruby

## [clag](https://github.com/sublayerapp/clag)

| | |
|---|---|
| **Version** | 0.0.7 |
| **Authors** | Scott Werner |
| **License** | MIT |
| **Ruby** | >= 3 |

Generate command line commands in your terminal using an LLM

Clag is a command line tool that generates command line commands right in your terminal and puts it into your clipboard for you to paste into your terminal.

**Dependencies:** cli-kit (~> 5), cli-ui (~> 2.2.3), ruby-openai (~> 6), httparty (~> 0.21), clipboard (~> 1.3), activesupport (>= 0), pry (>= 0), nokogiri (>= 0), sublayer (> 0.0.1)

## [claide](https://github.com/CocoaPods/CLAide)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Eloy Duran, Fabio Pelosin |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

A small command-line interface framework.

## [claide-plugins](https://github.com/cocoapods/claide-plugins)

| | |
|---|---|
| **Version** | 0.9.2 |
| **Authors** | David Grandinetti, Olivier Halligon |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

CLAide plugin which shows info about available CLAide plugins.

This CLAide plugin shows information about all available CLAide plugins (yes, this is very meta!). This plugin adds the "plugins" subcommand to a binary so that you can list all plugins (registered in the reference JSON hosted at CocoaPods/cocoapods-plugins)

**Dependencies:** nap (>= 0), cork (>= 0), open4 (~> 1.3)

## [clapton](https://github.com/kawakamimoeki/clapton)

| | |
|---|---|
| **Version** | 0.0.26 |
| **Authors** | Moeki Kawakami |
| **License** | MIT |

Clapton is a Ruby on Rails gem for building web apps with pure Ruby only (no JavaScript and no HTML templates).

**Dependencies:** rails (>= 6.1.7.8, < 8), ruby2js (~> 5), listen (~> 3), capybara (~> 3), execjs (~> 2), minitest (~> 5), rspec (~> 3)

## [classifier](https://rubyclassifier.com)

| | |
|---|---|
| **Version** | 2.3.2 |
| **Authors** | Lucas Carlson |
| **License** | LGPL |
| **Ruby** | >= 3.1 |

Text classification with Bayesian, LSI, Logistic Regression, kNN, and TF-IDF vectorization.

A Ruby library for text classification featuring Naive Bayes, LSI (Latent Semantic Indexing), Logistic Regression, and k-Nearest Neighbors classifiers. Includes TF-IDF vectorization, streaming/incremental training, pluggable persistence backends, thread safety, and a native C extension for fast LSI operations.

**Dependencies:** fast-stemmer (~> 1.0), mutex_m (~> 0.2), rake (>= 0), matrix (>= 0)

## [classifier-reborn](https://jekyll.github.io/classifier-reborn/)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Lucas Carlson, Parker Moore, Chase Gilliam |
| **License** | LGPL |
| **Ruby** | >= 2.4.0 |

A general classifier module to allow Bayesian and other types of classifications.

**Dependencies:** fast-stemmer (~> 1.0), matrix (~> 0.4)

## [claude-code-sdk-ruby](https://github.com/parruda/claude-code-sdk-ruby)

| | |
|---|---|
| **Version** | 0.1.6 |
| **Authors** | Paulo Arruda |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby SDK for Claude Code

Ruby SDK for interacting with Claude Code

**Dependencies:** async (~> 2), logger (~> 1)

## [claude-on-rails](https://github.com/obie/claude-on-rails)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Obie Fernandez |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Rails development framework powered by Claude swarm intelligence

ClaudeOnRails leverages claude-swarm to create an intelligent team of AI agents specialized in different aspects of Rails development. Simply describe what you want to build, and the swarm handles the rest.

**Dependencies:** claude_swarm (~> 0.1), rails (>= 6.0)

## [claude_code_slash_commands](https://github.com/andyw8/claude_code_slash_commands)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Andy Waite |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A tool for distributing Claude Code slash commands.

**Dependencies:** base64 (>= 0)

## [claude_memory](https://github.com/codenamev/claude_memory)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Valentino Stoll |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Long-term, self-managed memory for Claude Code

Turn-key Ruby gem providing Claude Code with instant, high-quality, long-term, self-managed memory using Claude Code Hooks + MCP + Output Style.

**Dependencies:** sequel (~> 5.0), extralite (~> 2.14)

## [claude_swarm](https://github.com/parruda/claude-swarm)

| | |
|---|---|
| **Version** | 0.3.11 |
| **Authors** | Paulo Arruda |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Orchestrate multiple Claude Code instances as a collaborative AI development team

Claude Swarm enables you to run multiple Claude Code instances that communicate with each other via MCP (Model Context Protocol). Create AI development teams where each instance has specialized roles, tools, and directory contexts. Define your swarm topology in simple YAML and let Claude instances collaborate across codebases. Perfect for complex projects requiring specialized AI agents for frontend, backend, testing, DevOps, or research tasks.

**Dependencies:** thor (~> 1.3), zeitwerk (~> 2.6), claude-code-sdk-ruby (~> 0.1), faraday-net_http_persistent (~> 2.0), faraday-retry (~> 2.0), fast-mcp-annotations (~> 1.5), ruby-mcp-client (~> 0.7), ruby-openai (>= 7.0, < 9.0)

## [clee](https://github.com/ahoward/clee)

| | |
|---|---|
| **Version** | 0.4.2 |
| **Authors** | Ara T. Howard |
| **License** | LicenseRef-LICENSE.md |
| **Ruby** | >= 3.0 |

`clee` is a tiny, 0 dependency, DSL for building über clean CLIs in Ruby

`clee` has everything you need, and nothing you don't

## [cli-kit](https://github.com/shopify/cli-kit)

| | |
|---|---|
| **Version** | 5.2.0 |
| **Authors** | Burke Libbey, Aaron Olson, Lisa Ugray, Don Kelly |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Terminal UI framework extensions

**Dependencies:** cli-ui (~> 2.4)

## [cli-ui](https://github.com/shopify/cli-ui)

| | |
|---|---|
| **Version** | 2.2.3 |
| **Authors** | Burke Libbey, Julian Nadeau, Lisa Ugray |
| **License** | MIT |

Terminal UI framework

## [cli_helper](http://github.com/MadBomber/cli_helper)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Dewayne VanHoozer |
| **License** | You want it?  It's yours. |

An encapsulation of an integration of slop, nenv, inifile and configatron.

An encapsulation of a convention I have been using with the slop, nenv, inifile and configatron gems for quick and dirty development of command-line based utility programs.  Slop parses ARGV; Nenv parses ENV; inifile parses INI; Configatron keeps it all together.  YAML and ERB preprocessing is also available.  Ruby configuration files are also supported. and you can specify multiple config files of mixed types at once.

**Dependencies:** configatron (>= 0), nenv (>= 0), inifile (>= 0), slop (~> 4.6)

## [climate_control](https://github.com/thoughtbot/climate_control)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Joshua Clayton, Dorian Marié |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Modify your ENV easily with ClimateControl

Modify your ENV

## [clipboard](https://github.com/janlelis/clipboard)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Access to the clipboard on Linux, MacOS, Windows, and Cygwin.

Access to the clipboard on Linux, MacOS, Windows, and Cygwin: Clipboard.copy, Clipboard.paste, Clipboard.clear

## [cliver](https://www.github.com/yaauie/cliver)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Ryan Biesemeyer |
| **License** | MIT |

Cross-platform version constraints for cli tools

Assertions for command-line dependencies

## [closure_tree](https://github.com/ClosureTree/closure_tree/)

| | |
|---|---|
| **Version** | 9.5.0 |
| **Authors** | Matthew McEachen, Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Easily and efficiently make your ActiveRecord model support hierarchies

**Dependencies:** activerecord (>= 7.2.0), with_advisory_lock (>= 7.5.0), zeitwerk (~> 2.7)

## [cmdx](https://github.com/drexed/cmdx)

| | |
|---|---|
| **Version** | 1.16.0 |
| **Authors** | Juan Gomez |
| **License** | LGPL-3.0 |
| **Ruby** | >= 3.1.0 |

CMDx is a framework for building maintainable business processes.

**Dependencies:** bigdecimal (>= 0), logger (>= 0), zeitwerk (>= 0)

## [cocos](https://github.com/rubycocos/cocos)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

cocos (code commons) - auto-include quick-starter prelude & prolog

**Dependencies:** csvreader (>= 1.2.5), tabreader (>= 1.0.1), iniparser (>= 1.0.1), webclient (>= 0.2.2)

## [code](https://github.com/janlelis/code)

| | |
|---|---|
| **Version** | 0.9.5 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Displays a method's code.

Displays a method's code (from source or docs). Supports native C source when core_docs gem is available

**Dependencies:** method_source (>= 0.9, < 2.0), coderay (~> 1.1)

## [code_analyzer](https://github.com/flyerhzm/code_analyzer)

| | |
|---|---|
| **Version** | 0.5.5 |
| **Authors** | Richard Huang |
| **License** | MIT |

a code analyzer helps you build your own code analyzer tool.

a code analyzer tool which extracted from rails_best_practices, it helps you easily build your own code analyzer tool.

**Dependencies:** sexp_processor (>= 0)

## [code_teams](https://github.com/rubyatscale/code_teams)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Gusto Engineers |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A low-dependency gem for declaring and querying engineering teams

**Dependencies:** sorbet-runtime (>= 0)

## [coderay](http://coderay.rubychan.de)

| | |
|---|---|
| **Version** | 1.1.3 |
| **Authors** | Kornelius Kalnbach |
| **License** | MIT |
| **Ruby** | >= 1.8.6 |

Fast syntax highlighting for selected languages.

Fast and easy syntax highlighting for selected languages, written in Ruby. Comes with RedCloth integration and LOC counter.

## [codex-sdk](https://github.com/ya-luotao/codex-sdk-ruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Tao Luo |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Unofficial Ruby SDK for Codex CLI

Unofficial Ruby SDK that wraps the Codex CLI binary. Embed the Codex agent in your Ruby workflows and apps.

## [coercible](https://github.com/solnic/coercible)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |

Powerful, flexible and configurable coercion library. And nothing more.

**Dependencies:** descendants_tracker (~> 0.0.1)

## [coffee-rails](https://github.com/rails/coffee-rails)

| | |
|---|---|
| **Version** | 5.0.0 |
| **Authors** | Santiago Pastorino |
| **License** | MIT |

CoffeeScript adapter for the Rails asset pipeline.

**Dependencies:** coffee-script (>= 2.2.0), railties (>= 5.2.0)

## [coffee-script](http://github.com/josh/ruby-coffee-script)

| | |
|---|---|
| **Version** | 2.4.1 |
| **Authors** | Jeremy Ashkenas, Joshua Peek, Sam Stephenson |
| **License** | MIT |

Ruby CoffeeScript Compiler

Ruby CoffeeScript is a bridge to the JS CoffeeScript compiler.

**Dependencies:** coffee-script-source (>= 0), execjs (>= 0)

## [coffee-script-source](http://coffeescript.org)

| | |
|---|---|
| **Version** | 1.11.1 |
| **Authors** | Jeremy Ashkenas |
| **License** | MIT |

The CoffeeScript Compiler

CoffeeScript is a little language that compiles into JavaScript. Underneath all of those embarrassing braces and semicolons, JavaScript has always had a gorgeous object model at its heart. CoffeeScript is an attempt to expose the good parts of JavaScript in a simple way.

## [cogger](https://alchemists.io/projects/cogger)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A customizable and feature rich logger.

**Dependencies:** core (~> 2.0), logger (~> 1.7), refinements (~> 13.5), tone (~> 2.0), zeitwerk (~> 2.7)

## [cohere-ai](https://github.com/gbaptista/cohere-ai)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | gbaptista |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Interact with Cohere AI.

A Ruby gem for interacting with Cohere AI platform.

**Dependencies:** faraday (~> 2.9), faraday-typhoeus (~> 1.1)

## [color](https://github.com/halostatue/color)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Austin Ziegler, Matt Lyon |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Color is a Ruby library to provide RGB, CMYK, HSL, and other color space manipulation support to applications that require it

Color is a Ruby library to provide RGB, CMYK, HSL, and other color space manipulation support to applications that require it. It provides optional named RGB colors that are commonly supported in HTML, SVG, and X11 applications.  The Color library performs purely mathematical manipulation of the colors based on color theory without reference to device color profiles (such as sRGB or Adobe RGB). For most purposes, when working with RGB and HSL color spaces, this won't matter. Absolute color spaces (like CIE LAB and CIE XYZ) cannot be reliably converted to relative color spaces (like RGB) without color profiles. When necessary for conversions, Color provides D65 and D50 reference white values in Color::XYZ.  Color 2.2 adds a minor feature where an RGB color created from values can silently inherit the `#name` of a predefined color if `color/rgb/colors` has already been loaded. It builds on the Color 2.0 major release, dropping support for all versions of Ruby prior to 3.2 as well as removing or renaming a number of features. The main breaking changes are:  - Color classes are immutable Data objects; they are no longer mutable. - RGB named colors are no longer loaded on gem startup, but must be required explicitly (this is _not_ done via `autoload` because there are more than 100 named colors with spelling variations) with `require "color/rgb/colors"`. - Color palettes have been removed. - `Color::CSS` and `Color::CSS#[]` have been removed.

## [colorator](https://github.com/octopress/colorator)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Parker Moore, Brandon Mathis |
| **License** | MIT |

Colorize your text in the terminal.

## [colored2](http://github.com/kigster/colored2)

| | |
|---|---|
| **Version** | 3.1.2 |
| **Authors** | Chris Wanstrath, Konstantin Gredeskoul |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Add even more color to your life.

This is a heavily modified fork of http://github.com/defunkt/colored gem, with many sensible pull requests combined. Since the authors of the original gem no longer support it, this might, perhaps, be considered a good alternative.  Simple gem that adds various color methods to String class, and can be used as follows:  require 'colored2'  puts 'this is red'.red puts 'this is red with a yellow background'.red.on.yellow puts 'this is red with and italic'.red.italic puts 'this is green bold'.green.bold << ' and regular'.green puts 'this is really bold blue on white but reversed'.bold.blue.on.white.reversed puts 'this is regular, but '.red! << 'this is red '.yellow! << ' and yellow.'.no_color! puts ('this is regular, but '.red! do 'this is red '.yellow! do ' and yellow.'.no_color! end end)

## [colorize](http://github.com/fazibear/colorize)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Michał Kalbarczyk |
| **License** | GPL-2.0 |
| **Ruby** | >= 2.6 |

Ruby gem for colorizing text using ANSI escape sequences.

Extends String class or add a ColorizedString with methods to set text color, background color and text effects.

## [colortail](http://codaset.com/elubow/colortail)

| | |
|---|---|
| **Version** | 0.1.7 |
| **Authors** | Eric Lubow |

Tail a file and color lines based on regular expressions within that line

Tail a file and color lines based on regular expressions within that line. By setting up multiple expression and color groups in the configuration file, you can apply highlighting to a file while its being tailed.

**Dependencies:** file-tail (>= 0)

## [colsole](https://github.com/DannyBen/colsole)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Colorful Console Applications

Utility functions for making colorful console applications

## [combine_pdf](https://github.com/boazsegev/combine_pdf)

| | |
|---|---|
| **Version** | 1.0.31 |
| **Authors** | Boaz Segev |
| **License** | MIT |

Combine, stamp and watermark PDF files in pure Ruby.

A nifty gem, in pure Ruby, to parse PDF files and combine (merge) them with other PDF files, number the pages, watermark them or stamp them, create tables, add basic text objects etc` (all using the PDF file format).

**Dependencies:** ruby-rc4 (>= 0.1.5), matrix (>= 0)

## [command_kit](https://github.com/postmodern/command_kit.rb#readme)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Postmodern |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

An all-in-one modular Ruby CLI toolkit

A modular Ruby toolkit for building clean, correct, and robust CLI commands as plain-old Ruby classes.

## [commonmarker](http://github.com/gjtorikian/commonmarker)

| | |
|---|---|
| **Version** | 0.17.13 |
| **Authors** | Garen Torikian, Ashe Connor |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

CommonMark parser and renderer. Written in C, wrapped in Ruby.

A fast, safe, extensible parser for CommonMark. This wraps the official libcmark library.

**Dependencies:** ruby-enum (~> 0.5)

## [completely](https://github.com/bashly-framework/completely)

| | |
|---|---|
| **Version** | 0.7.3 |
| **Authors** | Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Bash Completions Generator

Generate bash completion scripts using simple YAML configuration

**Dependencies:** colsole (~> 1.0.0), mister_bin (~> 0.7)

## [complex_config](https://github.com/flori/complex_config)

| | |
|---|---|
| **Version** | 0.25.0 |
| **Authors** | Florian Frank |
| **License** | Apache-2.0 |

configuration library

This library allows you to access configuration files via a simple interface

**Dependencies:** json (>= 0), tins (~> 1), mize (~> 0.6), base64 (>= 0)

## [concise_errors](https://github.com/obie/concise_errors)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Obie Fernandez |
| **Ruby** | >= 3.0.0 |

Minimal Rails error pages tuned for AI agents and compact debugging.

ConciseErrors replaces ActionDispatch::DebugExceptions with a compact error page that highlights the exception and a truncated backtrace, making Rails crashes easier for humans and AI helpers alike.

**Dependencies:** actionpack (>= 6.1, < 9.0)

## [concurrent-ruby](http://www.concurrent-ruby.com)

| | |
|---|---|
| **Version** | 1.3.6 |
| **Authors** | Jerry D'Antonio, Petr Chalupa, The Ruby Concurrency Team |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Modern concurrency tools for Ruby. Inspired by Erlang, Clojure, Scala, Haskell, F#, C#, Java, and classic concurrency patterns.

Modern concurrency tools including agents, futures, promises, thread pools, actors, supervisors, and more. Inspired by Erlang, Clojure, Go, JavaScript, actors, and classic concurrency patterns.

## [concurrent-ruby-edge](http://www.concurrent-ruby.com)

| | |
|---|---|
| **Version** | 0.7.2 |
| **Authors** | Jerry D'Antonio, Petr Chalupa, The Ruby Concurrency Team |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Edge features and additions to the concurrent-ruby gem.

These features are under active development and may change frequently. They are expected not to keep backward compatibility (there may also lack tests and documentation). Semantic versions will be obeyed though. Features developed in `concurrent-ruby-edge` are expected to move to `concurrent-ruby` when final. Please see http://concurrent-ruby.com for more information.

**Dependencies:** concurrent-ruby (~> 1.3)

## [concurrent-ruby-ext](http://www.concurrent-ruby.com)

| | |
|---|---|
| **Version** | 1.3.6 |
| **Authors** | Jerry D'Antonio, The Ruby Concurrency Team |
| **License** | MIT |
| **Ruby** | >= 2.3 |

C extensions to optimize concurrent-ruby under MRI.

C extensions to optimize the concurrent-ruby gem when running under MRI. Please see http://concurrent-ruby.com for more information.

**Dependencies:** concurrent-ruby (= 1.3.6)

## [config](https://github.com/rubyconfig/config)

| | |
|---|---|
| **Version** | 5.6.1 |
| **Authors** | Piotr Kuczynski, Fred Wu, Jacques Crocker |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Effortless multi-environment settings in Rails, Sinatra, Padrino and others

Easiest way to manage multi-environment settings in any ruby project or framework: Rails, Sinatra, Padrino and others

**Dependencies:** deep_merge (~> 1.2, >= 1.2.1), ostruct (>= 0)

## [configatron](https://github.com/markbates/configatron)

| | |
|---|---|
| **Version** | 4.5.1 |
| **Authors** | Mark Bates |
| **License** | MIT |

A powerful Ruby configuration system.

## [configuration](https://github.com/ahoward/configuration)

| | |
|---|---|
| **Version** | 1.3.4 |
| **Authors** | Ara T. Howard |
| **License** | same as ruby's |

configuration

ruby configuration for your ruby programs

## [connection_pool](https://github.com/mperham/connection_pool)

| | |
|---|---|
| **Version** | 2.5.5 |
| **Authors** | Mike Perham, Damian Janowski |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Generic connection pool for Ruby

## [console](https://socketry.github.io/console)

| | |
|---|---|
| **Version** | 1.34.2 |
| **Authors** | Samuel Williams, Robert Schulze, Bryan Powell, Michael Adams, Patrik Wenger, Anton Sozontov, Cyril Roelandt, Cédric Boutillier, Felix Yan, Olle Jonsson, Shigeru Nakajima, William T. Nelson, Yasha Krasnou |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Beautiful logging for Ruby.

**Dependencies:** fiber-annotation (>= 0), fiber-local (~> 1.1), json (>= 0)

## [console-adapter-rails](https://github.com/socketry/console-adapter-rails)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Samuel Williams, Joshua Young, Jun Jiang, Michael Adams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Adapt Rails logs and events to the console gem.

**Dependencies:** console (~> 1.21), fiber-storage (~> 1.0), rails (>= 7.0)

## [const_conf](https://github.com/flori/const_conf)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Florian Frank |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Clean DSL for config settings with validation and Rails integration

ConstConf is a Ruby configuration library that manages settings through environment variables, files, and directories with comprehensive validation and Rails integration.

**Dependencies:** tins (~> 1.43), json (~> 2.0), complex_config (~> 0.23), activesupport (~> 8)

## [constant_resolver](https://github.com/Shopify/constant_resolver)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Philip Müller |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Statically resolve any ruby constant

Given a code base that adheres to certain conventions, ConstantResolver resolves any, even partially qualified, constant to the path of the file that defines it.

## [containable](https://alchemists.io/projects/containable)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A thread-safe dependency injection container.

**Dependencies:** concurrent-ruby (~> 1.3)

## [content_disposition](https://github.com/shrinerb/content_disposition)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Jonathan Rochkind |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Ruby gem to create HTTP Content-Disposition headers with proper escaping/encoding of filenames

## [contracts](https://github.com/egonSchiele/contracts.ruby)

| | |
|---|---|
| **Version** | 0.17.3 |
| **Authors** | Aditya Bhargava |
| **License** | BSD-2-Clause |
| **Ruby** | >= 3.0, < 5 |

Contracts for Ruby.

This library provides contracts for Ruby. Contracts let you clearly express how your code behaves, and free you from writing tons of boilerplate, defensive code.

## [cookiejar](http://alkaline-solutions.com)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | David Waite |
| **License** | BSD-2-Clause |

Client-side HTTP Cookie library

Allows for parsing and returning cookies in Ruby HTTP client code

## [core](https://alchemists.io/projects/core)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A collection of foundational objects.

## [core_docs](https://github.com/janlelis/core_docs)

| | |
|---|---|
| **Version** | 0.9.13 |
| **Authors** | John Mair (banisterfiend), Jan Lelis (non-pry version) |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Provides YARD and extended documentation support

This gem enables you to be able to display the source code and the docs of Ruby methods and classes implemented in C.

**Dependencies:** yard (~> 0.9.11)

## [cork](https://github.com/CocoaPods/Cork)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Karla Sandoval, Orta Therox |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A delightful CLI UI module.

**Dependencies:** colored2 (~> 3.1)

## [cov-loupe](https://github.com/keithrbennett/cov-loupe)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Keith R. Bennett |
| **License** | MIT |
| **Ruby** | >= 3.2 |

MCP server + CLI for SimpleCov coverage data

Provides an MCP (Model Context Protocol) server and a CLI to inspect SimpleCov coverage, including per-file summaries and uncovered lines.

**Dependencies:** awesome_print (~> 1.9), mcp (~> 0.3), simplecov (>= 0.21, < 1.0)

## [coverband](https://github.com/danmayer/coverband)

| | |
|---|---|
| **Version** | 6.1.7 |
| **Authors** | Dan Mayer, Karl Baum |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Rack middleware to measure production code usage (LOC runtime usage)

**Dependencies:** redis (>= 3.0), base64 (>= 0)

## [crack](https://github.com/jnunemaker/crack)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | John Nunemaker |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Really simple JSON and XML parsing, ripped from Merb and Rails.

**Dependencies:** bigdecimal (>= 0), rexml (>= 0)

## [crass](https://github.com/rgrove/crass/)

| | |
|---|---|
| **Version** | 1.0.6 |
| **Authors** | Ryan Grove |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

CSS parser based on the CSS Syntax Level 3 spec.

Crass is a pure Ruby CSS parser based on the CSS Syntax Level 3 spec.

## [cronex](https://github.com/alpinweis/cronex)

| | |
|---|---|
| **Version** | 0.15.0 |
| **Authors** | Adrian Kazaku |
| **License** | Apache-2.0 |
| **Ruby** | >= 1.9.3 |

Ruby library that converts cron expressions into human readable strings

**Dependencies:** tzinfo (>= 0), unicode (>= 0.4.4.5)

## [crypt19-rb](https://github.com/coffeejunk/crypt19)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Jonathan Rudenberg, Richard Kernahan, Maximilian Haack |

Crypt is a pure-ruby implementation of a number of popular encryption algorithms.

Crypt is a pure-ruby implementation of a number of popular encryption algorithms. Block cyphers currently include Blowfish, GOST, IDEA, Rijndael (AES), and RC6. Cypher Block Chaining (CBC) has been implemented.

## [crystalball](https://github.com/toptal/crystalball)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Pavel Shutsin, Evgenii Pecherkin, Jaimerson Araujo |
| **Ruby** | > 2.3.0 |

A library for RSpec regression test selection

Provides simple way to integrate regression test selection approach to your RSpec test suite

**Dependencies:** git (>= 0)

## [crystalruby](https://github.com/wouterken/crystalruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Wouter Coppieters |
| **License** | MIT |
| **Ruby** | >= 2.7.2 |

Embed Crystal code directly in Ruby.

**Dependencies:** digest (>= 0), ffi (>= 0), fileutils (~> 1.7), prism (>= 1.3.0, < 1.5.0)

## [css-zero](https://github.com/lazaronixon/css-zero)

| | |
|---|---|
| **Version** | 1.1.15 |
| **Authors** | Lázaro Nixon |
| **License** | MIT |

An opinionated CSS starter kit for your application.

## [css_parser](https://github.com/premailer/css_parser)

| | |
|---|---|
| **Version** | 1.21.1 |
| **Authors** | Alex Dunae |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Ruby CSS parser.

A set of classes for parsing CSS in Ruby.

**Dependencies:** addressable (>= 0)

## [csv](https://github.com/ruby/csv)

| | |
|---|---|
| **Version** | 3.3.5 |
| **Authors** | James Edward Gray II, Kouhei Sutou |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

CSV Reading and Writing

The CSV library provides a complete interface to CSV files and data. It offers tools to enable you to read and write to and from Strings or IO objects, as needed.

## [csvjson](https://github.com/csvreader/csvjson)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

csvjson - read tabular data in the CSV <3 JSON format, that is, comma-separated values CSV (line-by-line) records with javascript object notation (JSON) encoding rules

## [csvreader](https://github.com/csvreader/csvreader)

| | |
|---|---|
| **Version** | 1.2.5 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

csvreader - read tabular data in the comma-separated values (csv) format the right way (uses best practices out-of-the-box with zero-configuration)

**Dependencies:** tabreader (>= 1.0.1), csvyaml (>= 0.1.0), csvjson (>= 1.0.0)

## [csvyaml](https://github.com/csvreader/csvyaml)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

csvyaml - read tabular data in the CSV <3 YAML format, that is, comma-separated values CSV (line-by-line) records with yaml ain't markup language (YAML) encoding rules

## [cucumber](https://cucumber.io/)

| | |
|---|---|
| **Version** | 10.2.0 |
| **Authors** | Aslak Hellesøy, Matt Wynne, Steve Tooke, Luke Hill |
| **License** | MIT |
| **Ruby** | >= 3.1 |

cucumber-10.2.0

Behaviour Driven Development with elegance and joy

**Dependencies:** base64 (~> 0.2), builder (~> 3.2), cucumber-ci-environment (> 9, < 12), cucumber-core (> 15, < 17), cucumber-cucumber-expressions (> 17, < 20), cucumber-html-formatter (> 21, < 23), diff-lcs (~> 1.5), logger (~> 1.6), mini_mime (~> 1.1), multi_test (~> 1.1), sys-uname (~> 1.3)

## [cucumber-ci-environment](https://github.com/cucumber/ci-environment)

| | |
|---|---|
| **Version** | 11.0.0 |
| **Authors** | Vincent Prêtre |
| **License** | MIT |
| **Ruby** | >= 3.2 |

cucumber-ci-environment-11.0.0

Detect CI Environment from environment variables

## [cucumber-core](https://cucumber.io)

| | |
|---|---|
| **Version** | 16.2.0 |
| **Authors** | Aslak Hellesøy, Matt Wynne, Steve Tooke, Oleg Sukhodolsky, Tom Brand |
| **License** | MIT |
| **Ruby** | >= 3.2 |

cucumber-core-16.2.0

Core library for the Cucumber BDD app

**Dependencies:** cucumber-gherkin (> 36, < 40), cucumber-messages (> 31, < 33), cucumber-tag-expressions (> 6, < 9)

## [cucumber-cucumber-expressions](https://github.com/cucumber/cucumber-expressions)

| | |
|---|---|
| **Version** | 19.0.0 |
| **Authors** | Aslak Hellesøy |
| **License** | MIT |
| **Ruby** | >= 2.7 |

cucumber-expressions-19.0.0

Cucumber Expressions - a simpler alternative to Regular Expressions

**Dependencies:** bigdecimal (>= 0)

## [cucumber-gherkin](https://github.com/cucumber/gherkin)

| | |
|---|---|
| **Version** | 38.0.0 |
| **Authors** | Gáspár Nagy, Aslak Hellesøy, Steve Tooke |
| **License** | MIT |
| **Ruby** | >= 3.2 |

cucumber-gherkin-38.0.0

Gherkin parser

**Dependencies:** cucumber-messages (>= 31, < 33)

## [cucumber-html-formatter](https://github.com/cucumber/html-formatter)

| | |
|---|---|
| **Version** | 22.3.0 |
| **Authors** | Vincent Prêtre |
| **License** | MIT |
| **Ruby** | >= 3.1 |

cucumber-html-formatter-22.3.0

HTML formatter for Cucumber

**Dependencies:** cucumber-messages (> 23, < 33)

## [cucumber-messages](https://github.com/cucumber/messages#readme)

| | |
|---|---|
| **Version** | 32.0.1 |
| **Authors** | Aslak Hellesøy |
| **License** | MIT |
| **Ruby** | >= 3.2 |

cucumber-messages-32.0.1

JSON schema-based messages for Cucumber's inter-process communication

## [cucumber-tag-expressions](https://cucumber.io/docs/cucumber/api/#tag-expressions)

| | |
|---|---|
| **Version** | 8.1.0 |
| **Authors** | Andrea Nodari, Aslak Hellesøy |
| **License** | MIT |
| **Ruby** | >= 2.6 |

cucumber-tag-expressions-8.1.0

Cucumber tag expressions for ruby

## [cuprite](https://github.com/rubycdp/cuprite)

| | |
|---|---|
| **Version** | 0.17 |
| **Authors** | Dmitry Vorotilin |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Headless Chrome driver for Capybara

Cuprite is a driver for Capybara that allows you to run your tests on a headless Chrome browser

**Dependencies:** capybara (~> 3.0), ferrum (~> 0.17.0)

## [curses](https://github.com/ruby/curses)

| | |
|---|---|
| **Version** | 1.5.3 |
| **Authors** | Shugo Maeda, Eric Hodel |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.0 |

A Ruby binding for curses, ncurses, and PDCurses. curses is an extension library for text UI applications. Formerly part of the Ruby standard library, [curses was removed and placed in this gem][1] with the release of Ruby 2.1.0. (see [ruby/ruby@9c5b2fd][2])

## [daemons](https://github.com/thuehlinger/daemons)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Thomas Uehlinger |
| **License** | MIT |

A toolkit to create and control daemons in different ways

Daemons provides an easy way to wrap existing ruby scripts (for example a self-written server)  to be run as a daemon and to be controlled by simple start/stop/restart commands.  You can also call blocks as daemons and control them from the parent or just daemonize the current process.  Besides this basic functionality, daemons offers many advanced features like exception backtracing and logging (in case your ruby script crashes) and monitoring and automatic restarting of your processes if they crash.

## [dagwood](https://github.com/rewindio/dagwood)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Rewind.io |
| **License** | MIT |

For all your dependency graph needs

Dagwood allows you to create dependency graphs for doing work in series or in parallel, always in the right order.

## [danger](https://github.com/danger/danger)

| | |
|---|---|
| **Version** | 9.5.3 |
| **Authors** | Orta Therox, Juanito Fatas |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Like Unit Tests, but for your Team Culture.

Stop Saying 'You Forgot To…' in Code Review

**Dependencies:** base64 (~> 0.2), claide (~> 1.0), claide-plugins (>= 0.9.2), colored2 (>= 3.1, < 5), cork (~> 0.1), faraday (>= 0.9.0, < 3.0), faraday-http-cache (~> 2.0), git (>= 1.13, < 3.0), kramdown (>= 2.5.1, < 3.0), kramdown-parser-gfm (~> 1.0), octokit (>= 4.0), pstore (~> 0.1), terminal-table (>= 1, < 5)

## [darwinning](https://github.com/dorkrawk/darwinning)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Dave Schwantes |

A Ruby gem to aid in the use of genetic algorithms.

Darwinning provides tools to build genetic algorithm solutions using a Gene, Organism, and Population structure.

## [data_migrate](https://github.com/ilyakatz/data-migrate)

| | |
|---|---|
| **Version** | 11.3.1 |
| **Authors** | Andrew J Vargo, Ilya Katz, Deborah Enomah |
| **License** | MIT |

Rake tasks to migrate data alongside schema changes.

**Dependencies:** activerecord (>= 6.1), railties (>= 6.1)

## [data_uri](http://github.com/dball/data_uri)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Donald Ball |

A URI class for parsing data URIs as per RFC2397

URI class for parsing data URIs

## [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Ben Mabey, Ernesto Tagwerker, Micah Geisel |
| **License** | MIT |

Strategies for cleaning databases. Can be used to ensure a clean slate for testing.

**Dependencies:** database_cleaner-active_record (>= 2, < 3)

## [database_cleaner-active_record](https://github.com/DatabaseCleaner/database_cleaner-active_record)

| | |
|---|---|
| **Version** | 2.2.2 |
| **Authors** | Ernesto Tagwerker, Micah Geisel |
| **License** | MIT |

Strategies for cleaning databases using ActiveRecord. Can be used to ensure a clean state for testing.

**Dependencies:** database_cleaner-core (~> 2.0), activerecord (>= 5.a)

## [database_cleaner-core](https://github.com/DatabaseCleaner/database_cleaner)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Ben Mabey, Ernesto Tagwerker |
| **License** | MIT |

Strategies for cleaning databases. Can be used to ensure a clean slate for testing.

## [database_consistency](https://github.com/djezzzl/database_consistency)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Evgeniy Demin |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Provide an easy way to check the consistency of the database constraints with the application validations.

**Dependencies:** activerecord (>= 3.2)

## [database_rewinder](https://github.com/amatsuda/database_rewinder)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Akira Matsuda |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A minimalist's tiny and ultra-fast database cleaner

A minimalist's tiny and ultra-fast database cleaner for Active Record

## [database_validations](https://github.com/toptal/database_validations)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Evgeniy Demin |
| **License** | MIT |

Provide compatibility between database constraints and ActiveRecord validations with better performance and consistency.

ActiveRecord provides validations on app level but it won't guarantee the consistent. In some cases, like `validates_uniqueness_of` it executes additional SQL query to the database and that is not very efficient.  The main goal of the gem is to provide compatibility between database constraints and ActiveRecord validations with better performance and consistency.

**Dependencies:** activerecord (>= 4.2.0)

## [date](https://github.com/ruby/date)

| | |
|---|---|
| **Version** | 3.5.1 |
| **Authors** | Tadayoshi Funaba |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

The official date library for Ruby.

## [dead_end](https://github.com/zombocom/dead_end.git)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | schneems |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Find syntax errors in your source in a snap

When you get an "unexpected end" in your syntax this gem helps you find it

## [debug](https://github.com/ruby/debug)

| | |
|---|---|
| **Version** | 1.11.1 |
| **Authors** | Koichi Sasada |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Debugging functionality for Ruby

Debugging functionality for Ruby. This is completely rewritten debug.rb which was contained by the ancient Ruby versions.

**Dependencies:** irb (~> 1.10), reline (>= 0.3.8)

## [debug_inspector](https://github.com/banister/debug_inspector)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | John Mair (banisterfiend) |
| **License** | MIT |
| **Ruby** | >= 2.0 |

A Ruby wrapper for the MRI 2.0 debug_inspector API

Adds methods to DebugInspector to allow for inspection of backtrace frames.  The debug_inspector C extension and API were designed and built by Koichi Sasada, this project is just a gemification of his work.  This library makes use of the debug inspector API which was added to MRI 2.0.0. Only works on MRI 2 and 3. Requiring it on unsupported Rubies will result in a no-op.  Recommended for use only in debugging situations. Do not use this in production apps.

## [debug_me](http://github.com/MadBomber/debug_me)

| | |
|---|---|
| **Version** | 1.1.3 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

A tool to print the labeled value of variables.

This thing is pretty old.  There are much better ways of debugging in a complex application.  But, you know, I keep returning to this little method time after time.  I guess that marks me as a geezer.

## [debugbar](https://debugbar.dev)

| | |
|---|---|
| **Version** | 0.4.3 |
| **Authors** | Julien Bourdeau |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Powerful devtools for Ruby on Rails

Get a better understanding of your application performance and behavior (SQL queries, jobs, cache, routes, logs, etc)

**Dependencies:** rails (>= 0), actioncable (>= 0)

## [debugging](https://github.com/janlelis/debugging)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Print debugging helpers

Utilities for better "print debugging"

**Dependencies:** paint (>= 0.9, < 3.0)

## [decant](https://github.com/benpickles/decant)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Ben Pickles |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A dependency-free frontmatter-aware framework-agnostic wrapper around a directory of static content

## [declarative](https://github.com/apotonick/declarative)

| | |
|---|---|
| **Version** | 0.0.20 |
| **Authors** | Nick Sutterer |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

DSL for nested schemas.

DSL for nested generic schemas with inheritance and refining.

## [deep-cover](https://github.com/deep-cover/deep-cover)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Marc-André Lafortune, Maxime Lapointe |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

In depth coverage of your Ruby code.

expression and branch coverage for Ruby.

**Dependencies:** deep-cover-core (= 1.1.0), highline (>= 0), thor (>= 0.20.3), with_progress (>= 0)

## [deep-cover-core](https://github.com/deep-cover/deep-cover)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Marc-André Lafortune, Maxime Lapointe |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

In depth coverage of your Ruby code.

Core functionality for the DeepCover gem.

**Dependencies:** parser (>= 2.5), backports (>= 3.11.0), binding_of_caller (>= 0), term-ansicolor (>= 0), terminal-table (>= 0), pry (>= 0)

## [deep_merge](https://github.com/danielsdeleo/deep_merge)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | Steve Midgley |
| **License** | MIT |

Merge Deeply Nested Hashes

Recursively merge hashes.

## [delegate](https://github.com/ruby/delegate)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.0 |

Provides three abilities to delegate method calls to an object.

## [dentaku](http://github.com/rubysolo/dentaku)

| | |
|---|---|
| **Version** | 3.5.7 |
| **Authors** | Solomon White |
| **License** | MIT |

A formula language parser and evaluator

Dentaku is a parser and evaluator for mathematical formulas

**Dependencies:** bigdecimal (>= 0), concurrent-ruby (>= 0)

## [derailed_benchmarks](https://github.com/zombocom/derailed_benchmarks)

| | |
|---|---|
| **Version** | 2.2.1 |
| **Authors** | Richard Schneeman |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Benchmarks designed to performance test your ENTIRE site

Go faster, off the Rails

**Dependencies:** heapy (~> 0), memory_profiler (>= 0, < 2), get_process_mem (>= 0), benchmark-ips (~> 2), rack (>= 1), rake (> 10, < 14), thor (>= 0.19, < 2), ruby-statistics (>= 4.0.1), mini_histogram (>= 0.3.0), rack-test (>= 0), base64 (>= 0), mutex_m (>= 0), bigdecimal (>= 0), drb (>= 0), logger (>= 0), ostruct (>= 0), ruby2_keywords (>= 0)

## [descendants_tracker](https://github.com/dkubb/descendants_tracker)

| | |
|---|---|
| **Version** | 0.0.4 |
| **Authors** | Dan Kubb, Piotr Solnica, Markus Schirp |
| **License** | MIT |

Module that adds descendant tracking to a class

**Dependencies:** thread_safe (~> 0.3, >= 0.3.1)

## [descriptive_statistics](https://github.com/thirtysixthspan/descriptive_statistics)

| | |
|---|---|
| **Version** | 2.5.1 |
| **Authors** | Derrick Parkhurst, Gregory Brown, Daniel Farrell, Graham Malmgren, Guy Shechter, Charlie Egan |
| **License** | MIT |

Descriptive Statistics

Adds descriptive statistics methods to Enumerable module for use on collections or Numeric data

## [desiru](https://github.com/obie/desiru)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Obie Fernandez |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Declarative Self-Improving Ruby - A Ruby port of DSPy

Desiru brings DSPy's declarative programming paradigm for language models to Ruby, enabling reliable, maintainable, and portable AI programming.

**Dependencies:** forwardable (~> 1.3), redis (~> 5.0), sidekiq (~> 7.2), singleton (~> 0.1)

## [device_detector](http://podigee.github.io/device_detector)

| | |
|---|---|
| **Version** | 1.1.3 |
| **Authors** | Mati Sójka, Ben Zimmer |
| **License** | LGPL-3.0 |
| **Ruby** | >= 2.7.5 |

Precise and fast user agent parser and device detector

Precise and fast user agent parser and device detector, backed by the largest and most up-to-date agent and device database

## [devise](https://github.com/heartcombo/devise)

| | |
|---|---|
| **Version** | 4.9.4 |
| **Authors** | José Valim, Carlos Antônio |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

Flexible authentication solution for Rails with Warden

**Dependencies:** warden (~> 1.2.3), orm_adapter (~> 0.1), bcrypt (~> 3.0), railties (>= 4.1.0), responders (>= 0)

## [devise-otp](https://github.com/wmlele/devise-otp)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Lele Forzani, Josef Strzibny, Laney Stroup |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Time Based OTP/rfc6238 compatible authentication for Devise

OTP authentication for Devise

**Dependencies:** rails (>= 7.1), devise (>= 4.8.0, < 5.0), rotp (>= 2.0.0), rqrcode (~> 3.0)

## [diagram](https://github.com/seuros/diagram-ruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Work with diagrams in Ruby

**Dependencies:** dry-equalizer (>= 0.2), dry-struct (>= 1.6.0), dry-types (>= 1.0), json (>= 0), zeitwerk (>= 2.6)

## [did_you_mean](https://github.com/ruby/did_you_mean)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Yuki Nishijima |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

"Did you mean?" experience in Ruby

The gem that has been saving people from typos since 2014.

## [diff-lcs](https://github.com/halostatue/diff-lcs)

| | |
|---|---|
| **Version** | 1.6.2 |
| **Authors** | Austin Ziegler |
| **License** | MIT, Artistic-1.0-Perl, GPL-2.0-or-later |
| **Ruby** | >= 1.8 |

Diff::LCS computes the difference between two Enumerable sequences using the McIlroy-Hunt longest common subsequence (LCS) algorithm

Diff::LCS computes the difference between two Enumerable sequences using the McIlroy-Hunt longest common subsequence (LCS) algorithm. It includes utilities to create a simple HTML diff output format and a standard diff-like tool.  This is release 1.6.1, providing a simple extension that allows for Diff::LCS::Change objects to be treated implicitly as arrays and fixes a number of formatting issues.  Ruby versions below 2.5 are soft-deprecated, which means that older versions are no longer part of the CI test suite. If any changes have been introduced that break those versions, bug reports and patches will be accepted, but it will be up to the reporter to verify any fixes prior to release. The next major release will completely break compatibility.

## [difftastic](https://github.com/joeldrapper/difftastic-ruby)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Joel Drapper |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Integrate Difftastic with the RubyGems infrastructure.

**Dependencies:** pretty_please (>= 0)

## [diffy](http://github.com/samg/diffy)

| | |
|---|---|
| **Version** | 3.4.4 |
| **Authors** | Sam Goldstein |
| **License** | MIT |

A convenient way to diff string in ruby

Convenient diffing in ruby

## [digest](https://github.com/ruby/digest)

| | |
|---|---|
| **Version** | 3.2.1 |
| **Authors** | Akinori MUSHA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Provides a framework for message digest libraries.

## [digest-crc](https://github.com/postmodern/digest-crc#readme)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Postmodern |
| **License** | MIT |

A Cyclic Redundancy Check (CRC) library for Ruby.

Adds support for calculating Cyclic Redundancy Check (CRC) to the Digest module.

**Dependencies:** rake (>= 12.0.0, < 14.0.0)

## [digest-xxhash](https://github.com/konsolebox/digest-xxhash-ruby)

| | |
|---|---|
| **Version** | 0.2.9 |
| **Authors** | konsolebox |
| **License** | MIT |
| **Ruby** | >= 2.2 |

A Digest framework based XXHash library for Ruby

This gem provides XXH32, XXH64, XXH3_64bits and XXH3_128bits functionalities for Ruby.  It inherits Digest::Class and complies with Digest::Instance's functional design.

## [discard](https://github.com/jhawthorn/discard)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | John Hawthorn |
| **License** | MIT |

ActiveRecord soft-deletes done right

Allows marking ActiveRecord objects as discarded, and provides scopes for filtering.

**Dependencies:** activerecord (>= 4.2, < 9.0)

## [discordrb](https://github.com/shardlab/discordrb)

| | |
|---|---|
| **Version** | 3.7.2 |
| **Authors** | meew0, swarley |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Discord API for Ruby

A Ruby implementation of the Discord (https://discord.com) API.

**Dependencies:** base64 (~> 0.2), ffi (>= 1.9.24), opus-ruby (>= 0), rest-client (>= 2.0.0), websocket-client-simple (>= 0.9.0), discordrb-webhooks (~> 3.7.2)

## [discordrb-webhooks](https://github.com/shardlab/discordrb)

| | |
|---|---|
| **Version** | 3.7.2 |
| **Authors** | meew0, swarley |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Webhook client for discordrb

A client for Discord's webhooks to fit alongside [discordrb](https://rubygems.org/gems/discordrb).

**Dependencies:** rest-client (>= 2.0.0)

## [dispersion](https://github.com/joeldrapper/dispersion)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Joel Drapper |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Syntac Highlighter for Ruby

**Dependencies:** prism (>= 0)

## [disposable](https://github.com/apotonick/disposable)

| | |
|---|---|
| **Version** | 0.6.3 |
| **Authors** | Nick Sutterer |
| **License** | MIT |

Decorators on top of your ORM layer with change tracking, collection semantics and nesting.

Decorators on top of your ORM layer.

**Dependencies:** declarative (>= 0.0.9, < 1.0.0), representable (>= 3.1.1, < 4)

## [dnsruby](https://github.com/alexdalitz/dnsruby)

| | |
|---|---|
| **Version** | 1.73.1 |
| **Authors** | Alex Dalitz |
| **License** | Apache License, Version 2.0 |
| **Ruby** | >= 2.8.0 |

Ruby DNS(SEC) implementation

Dnsruby is a pure Ruby DNS client library which implements a stub resolver. It aims to comply with all DNS RFCs, including DNSSEC NSEC3 support.

**Dependencies:** base64 (>= 0.2), logger (~> 1.6), simpleidn (~> 0.2.1)

## [dnssd](https://github.com/tenderlove/dnssd)

| | |
|---|---|
| **Version** | 3.0.2 |
| **Authors** | Eric Hodel, Aaron Patterson, Phil Hagelberg, Chad Fowler, Charles Mills, Rich Kilmer |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

DNS Service Discovery (aka Bonjour, MDNS) API for Ruby

DNS Service Discovery (aka Bonjour, MDNS) API for Ruby.  Implements browsing, resolving, registration and domain enumeration.  Supports avahi's DNSSD compatibility layer for avahi 0.6.25 or newer.

## [docile](https://ms-ati.github.io/docile/)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Marc Siegel |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Docile keeps your Ruby DSLs tame and well-behaved.

Docile treats the methods of a given ruby object as a DSL (domain specific language) within a given block.  Killer feature: you can also reference methods, instance variables, and local variables from the original (non-DSL) context within the block.  Docile releases follow Semantic Versioning as defined at semver.org.

## [docker-api](https://github.com/upserve/docker-api)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Swipely, Inc. |
| **License** | MIT |

A simple REST client for the Docker Remote API

**Dependencies:** excon (>= 0.64.0), multi_json (>= 0)

## [docker_mcp](https://github.com/afstanton/docker_mcp)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Aaron F Stanton |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A gem to manage Docker via MCP.

This gem provides tools to manage Docker containers and images using MCP.

**Dependencies:** base64 (>= 0), docker-api (>= 0), mcp (>= 0), tool_forge (>= 0), zeitwerk (>= 0)

## [docopt](http://github.com/docopt/docopt.rb)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Blake Williams, Vladimir Keleshev, Alex Speller, Nima Johari |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

A command line option parser, that will make you smile.

Isn't it awesome how `optparse` and other option parsers generate help and usage-messages based on your code?! Hell no! You know what's awesome? It's when the option parser *is* generated based on the help and usage-message that you write in a docstring! That's what docopt does!

## [docopt_ng](https://github.com/dannyben/docopt_ng)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | Blake Williams, Vladimir Keleshev, Alex Speller, Nima Johari, Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A command line option parser that will make you smile

Parse command line arguments from nothing more than a usage message

## [docx](https://github.com/chrahunt/docx)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Christopher Hunt, Marcus Ortiz, Higgins Dragon, Toms Mikoss, Sebastian Wittenkamp |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

a ruby library/gem for interacting with .docx files

thin wrapper around rubyzip and nokogiri as a way to get started with docx files

**Dependencies:** nokogiri (~> 1.13, >= 1.13.0), rubyzip (>= 2.0, < 4)

## [doll](https://github.com/elct9620/doll)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | 蒼時弦也 |

Doll is a chat bot framework.

## [domain_name](https://github.com/knu/ruby-domain_name)

| | |
|---|---|
| **Version** | 0.6.20240107 |
| **Authors** | Akinori MUSHA |
| **License** | BSD-2-Clause, BSD-3-Clause, MPL-2.0 |
| **Ruby** | >= 2.7.0 |

Domain Name manipulation library for Ruby

This is a Domain Name manipulation library for Ruby.  It can also be used for cookie domain validation based on the Public Suffix List.

## [dotenv](https://github.com/bkeepers/dotenv)

| | |
|---|---|
| **Version** | 2.8.1 |
| **Authors** | Brandon Keepers |
| **License** | MIT |

Loads environment variables from `.env`.

## [dotenv-rails](https://github.com/bkeepers/dotenv)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Brandon Keepers |
| **License** | MIT |

Autoload dotenv in Rails.

**Dependencies:** dotenv (= 3.2.0), railties (>= 6.1)

## [dotum](https://github.com/nevir/dotum)

| | |
|---|---|
| **Version** | 0.0.0 |
| **Authors** | Ian MacLeod |

Dotum manages your dotfiles and allows for piecemeal sharing.

## [down](https://github.com/janko/down)

| | |
|---|---|
| **Version** | 5.4.2 |
| **Authors** | Janko Marohnić |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Robust streaming downloads using Net::HTTP, HTTP.rb or wget.

**Dependencies:** addressable (~> 2.8)

## [dragonfly](http://github.com/markevans/dragonfly)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Mark Evans |
| **License** | MIT |

Ideal gem for handling attachments in Rails, Sinatra and Rack applications.

Dragonfly is a framework that enables on-the-fly processing for any content type. It is especially suited to image handling. Its uses range from image thumbnails to standard attachments to on-demand text generation.

**Dependencies:** rack (>= 1.3), multi_json (~> 1.0), addressable (~> 2.3), ostruct (~> 0.6.1)

## [dragonfly_svg](https://github.com/tomasc/dragonfly_svg)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Tomas Celizna |
| **License** | MIT |

Dragonfly analyser and processor for SVGs.

**Dependencies:** dragonfly (~> 1.0), nokogiri (>= 0)

## [drb](https://github.com/ruby/drb)

| | |
|---|---|
| **Version** | 2.2.3 |
| **Authors** | Masatoshi SEKI |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Distributed object system for Ruby

## [drg_material_icons](https://github.com/drgcms/drg-material-icons)

| | |
|---|---|
| **Version** | 0.24.3 |
| **Authors** | Damjan Rems |
| **License** | MIT |
| **Ruby** | >= 2 |

an asset gemification of the Google Material icon font library

drg_material_icons provides Google Material icon web fonts and stylesheets as a Rails engine for use with the asset pipeline.

**Dependencies:** railties (>= 0)

## [dry-cli](https://dry-rb.org/gems/dry-cli)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Common framework to build command line interfaces with Ruby

## [dry-configurable](https://dry-rb.org/gems/dry-configurable)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Andy Holland |
| **License** | MIT |
| **Ruby** | >= 3.1 |

A mixin to add configuration functionality to your classes

**Dependencies:** dry-core (~> 1.1), zeitwerk (~> 2.6)

## [dry-container](https://dry-rb.org/gems/dry-container)

| | |
|---|---|
| **Version** | 0.11.0 |
| **Authors** | Andy Holland |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A simple, configurable object container implemented in Ruby

**Dependencies:** concurrent-ruby (~> 1.0)

## [dry-core](https://dry-rb.org/gems/dry-core)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A toolset of small support modules used throughout the dry-rb ecosystem

**Dependencies:** concurrent-ruby (~> 1.0), logger (>= 0), zeitwerk (~> 2.6)

## [dry-effects](https://dry-rb.org/gems/dry-effects)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Nikita Shilnikov |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Algebraic effects

**Dependencies:** concurrent-ruby (~> 1.0), dry-core (~> 1.1), dry-inflector (~> 1.1), dry-initializer (~> 3.2), zeitwerk (~> 2.6)

## [dry-equalizer](https://github.com/dry-rb/dry-equalizer)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Dan Kubb, Markus Schirp |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Module to define equality, equivalence and inspection methods

## [dry-events](https://dry-rb.org/gems/dry-events)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Pub/sub system

**Dependencies:** concurrent-ruby (~> 1.0), dry-core (~> 1.1)

## [dry-graphql](https://github.com/adhawk/dry-graphql)

| | |
|---|---|
| **Version** | 2.2.2 |
| **Authors** | Ian Ker-Seymer |
| **License** | MIT |

Integrate dry-types/dry-struct with graphql-ruby

Adds functionality to make dry-types/dry-struct play nicely with graphql-ruby

**Dependencies:** dry-struct (~> 1.0), dry-types (~> 1.1), graphql (~> 1.10)

## [dry-inflector](https://dry-rb.org/gems/dry-inflector)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

String inflections for dry-rb

## [dry-initializer](https://dry-rb.org/gems/dry-initializer)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Vladimir Kochnev (marshall-lee), Andrew Kozin (nepalez) |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

DSL for declaring params and options of the initializer

## [dry-logger](https://dry-rb.org/gems/dry-logger)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Lightweight structured logging for Ruby applications

**Dependencies:** logger (>= 0)

## [dry-logic](https://dry-rb.org/gems/dry-logic)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Predicate logic with rule composition

**Dependencies:** bigdecimal (>= 0), concurrent-ruby (~> 1.0), dry-core (~> 1.1), zeitwerk (~> 2.6)

## [dry-monads](https://dry-rb.org/gems/dry-monads)

| | |
|---|---|
| **Version** | 1.9.0 |
| **Authors** | Nikita Shilnikov |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Common monads for Ruby

**Dependencies:** concurrent-ruby (~> 1.0), dry-core (~> 1.1), zeitwerk (~> 2.6)

## [dry-monitor](https://dry-rb.org/gems/dry-monitor)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Monitoring and instrumentation APIs

**Dependencies:** dry-configurable (~> 1.0, < 2), dry-core (~> 1.0, < 2), dry-events (~> 1.0, < 2)

## [dry-schema](https://dry-rb.org/gems/dry-schema)

| | |
|---|---|
| **Version** | 1.15.0 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Coercion and validation for data structures

dry-schema provides a DSL for defining schemas with keys and rules that should be applied to values. It supports coercion, input sanitization, custom types and localized error messages (with or without I18n gem). It's also used as the schema engine in dry-validation.

**Dependencies:** concurrent-ruby (~> 1.0), zeitwerk (~> 2.6), dry-core (~> 1.1), dry-configurable (~> 1.0, >= 1.0.1), dry-initializer (~> 3.2), dry-logic (~> 1.6), dry-types (~> 1.8)

## [dry-struct](https://dry-rb.org/gems/dry-struct)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Typed structs and value objects

**Dependencies:** dry-core (~> 1.0, < 2), dry-types (>= 1.7, < 2), ice_nine (~> 0.11), zeitwerk (~> 2.6)

## [dry-types](https://dry-rb.org/gems/dry-types)

| | |
|---|---|
| **Version** | 1.9.1 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Type system for Ruby supporting coercions, constraints and complex types like structs, value objects, enums etc

**Dependencies:** bigdecimal (>= 3.0), concurrent-ruby (~> 1.0), dry-core (~> 1.0), dry-inflector (~> 1.0), dry-logic (~> 1.4), zeitwerk (~> 2.6)

## [dry-validation](https://dry-rb.org/gems/dry-validation)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Validation library

**Dependencies:** concurrent-ruby (~> 1.0), dry-core (~> 1.0, < 2), dry-initializer (~> 3.0), dry-schema (>= 1.12, < 2), zeitwerk (~> 2.6)

## [dspy-schema](https://github.com/vicentereig/dspy.rb)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Vicente Reig Rincón de Arellano |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Sorbet to JSON Schema conversion utilities reused by DSPy.rb.

Provides DSPy::TypeSystem::SorbetJsonSchema without requiring the full DSPy stack, enabling reuse in sibling gems and downstream projects.

**Dependencies:** sorbet-runtime (>= 0.5.0)

## [ductwork](https://github.com/ductwork/ductwork)

| | |
|---|---|
| **Version** | 0.20.2 |
| **Authors** | Tyler Ewing |
| **License** | LGPL-3.0-or-later |
| **Ruby** | >= 3.2.0 |

A Ruby pipeline framework

Ductwork lets you build complex pipelines quickly and easily using intuitive Ruby tooling and a natural DSL.

**Dependencies:** actionpack (>= 7.1, < 8.3), activerecord (>= 7.1, < 8.3), activesupport (>= 7.1, < 8.3), railties (>= 7.1, < 8.3), zeitwerk (~> 2.7)

## [dynamicschema](https://github.com/EndlessInternational/dynamic_schema)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Kristoph Cichocki-Romanov |
| **License** | MIT |
| **Ruby** | >= 3.0 |

DynamicSchema is a lightweight and simple yet powerful gem that enables flexible semantic   schema definitions for constructing and validating complex configurations and other similar  payloads.

The DynamicSchema gem provides a elegant and expressive way to define a domain-specific  language (DSL) schemas, making it effortless to build and validate complex Ruby hashes.  This is particularly useful when dealing with intricate configurations or  interfacing with external APIs, where data structures need to adhere to specific formats  and validations. By allowing default values, type constraints, nested schemas, and  transformations, DynamicSchema ensures that your data structures are both robust and  flexible.

## [e2mmap](https://github.com/ruby/e2mmap)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Keiju ISHITSUKA |
| **License** | BSD-2-Clause |

Module for defining custom exceptions with specific messages.

## [easy_talk](https://github.com/sergiobayona/easy_talk)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Sergio Bayona |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Generate json-schema from Ruby classes.

Generate json-schema from plain Ruby classes.

**Dependencies:** activemodel (~> 7.0), activesupport (~> 7.0), json_schemer (>= 0), sorbet-runtime (~> 0.5)

## [easy_talk_two](https://github.com/a-chacon/easy_talk)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | a-chacon |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Generate json-schema from Ruby classes.

Generate json-schema from plain Ruby classes.

**Dependencies:** activemodel (>= 7.0), activesupport (>= 7.0), sorbet-runtime (>= 0.5)

## [ect](http://github.com/jmettraux/ect)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | John Mettraux |
| **License** | MIT |

Methods ending in ect

Methods ending in ect. Mostly a joke.

## [ed25519](https://github.com/RubyCrypto/ed25519)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Tony Arcieri |
| **License** | MIT |
| **Ruby** | >= 3.0 |

An efficient digital signature library providing the Ed25519 algorithm

A Ruby binding to the Ed25519 elliptic curve public-key signature system described in RFC 8032.

## [editor_opener](https://github.com/igorkasyanchuk/editor_opener)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Igor Kasyanchuk |
| **License** | MIT |

Open source file in the editor from the Rails error page

**Dependencies:** rails (>= 0)

## [ejson](https://github.com/Shopify/ejson)

| | |
|---|---|
| **Version** | 1.5.3 |
| **Authors** | Shopify |
| **License** | MIT |

Asymmetric keywise encryption for JSON

Secret management by encrypting values in a JSON hash with a public/private keypair

## [em-http-request](http://github.com/igrigorik/em-http-request)

| | |
|---|---|
| **Version** | 1.1.7 |
| **Authors** | Ilya Grigorik |
| **License** | MIT |

EventMachine based, async HTTP Request client

**Dependencies:** addressable (>= 2.3.4), cookiejar (!= 0.3.1), em-socksify (>= 0.3), eventmachine (>= 1.0.3), http_parser.rb (>= 0.6.0)

## [em-socksify](https://github.com/igrigorik/em-socksify)

| | |
|---|---|
| **Version** | 0.3.3 |
| **Authors** | Ilya Grigorik |
| **License** | MIT |

Transparent proxy support for any EventMachine protocol

**Dependencies:** base64 (>= 0), eventmachine (>= 1.0.0.beta.4)

## [em-websocket](http://github.com/igrigorik/em-websocket)

| | |
|---|---|
| **Version** | 0.5.3 |
| **Authors** | Ilya Grigorik, Martyn Loughran |
| **License** | MIT |

EventMachine based WebSocket server

**Dependencies:** eventmachine (>= 0.12.9), http_parser.rb (~> 0)

## [email_validator](https://github.com/K-and-R/email_validator)

| | |
|---|---|
| **Version** | 2.2.4 |
| **Authors** | Brian Alexander, Karl Wilbur |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

An email validator for Rails 3+.

An email validator for Rails 3+. See homepage for details: http://github.com/K-and-R/email_validator

**Dependencies:** activemodel (>= 0)

## [encryptor](http://github.com/attr-encrypted/encryptor)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Sean Huber, S. Brent Faulkner, William Monk, Stephen Aghaulor |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A simple wrapper for the standard ruby OpenSSL library

A simple wrapper for the standard ruby OpenSSL library to encrypt and decrypt strings

## [english](https://github.com/ruby/English)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Require 'English.rb' to reference global variables with less cryptic names.

## [engtagger](http://github.com/yohasebe/engtagger)

| | |
|---|---|
| **Version** | 0.4.2 |
| **Authors** | Yoichiro Hasebe |
| **License** | GPL |
| **Ruby** | >= 2.6 |

A probability based, corpus-trained English POS tagger

A Ruby port of Perl Lingua::EN::Tagger, a probability based, corpus-trained tagger that assigns POS tags to English text based on a lookup dictionary and a set of probability values.

**Dependencies:** sin_lru_redux (>= 0)

## [enumerable-statistics](https://github.com/red-data-tools/enumerable-statistics)

| | |
|---|---|
| **Version** | 2.0.9 |
| **Authors** | Kenta Murata |
| **Ruby** | >= 2.4 |

Statistics features for Enumerable

This library provides statistics features for Enumerable

## [ephem](https://github.com/rhannequin/ruby-ephem)

| | |
|---|---|
| **Version** | 0.4.1 |
| **Authors** | Rémy Hannequin |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Compute astronomical ephemerides from NASA/JPL DE and IMCCE INPOP

Ruby implementation of the parsing and computation of ephemerides from NASA/JPL Development Ephemerides DE4xx and IMCCE INPOP

**Dependencies:** minitar (~> 0.12), numo-narray (~> 0.9.2.1), zlib (~> 3.2)

## [eps](https://github.com/ankane/eps)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Machine learning for Ruby. Supports regression (linear regression) and classification (naive Bayes)

**Dependencies:** lightgbm (>= 0.1.7), matrix (>= 0), nokogiri (>= 0)

## [equatable](https://github.com/piotrmurach/equatable)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Provide equality comparison methods for objects based on their attributes.

Provide equality comparison methods for objects based on their attributes by generating implementations for the ==, eql?, hash and inspect methods.

## [erb](https://github.com/ruby/erb)

| | |
|---|---|
| **Version** | 5.1.3 |
| **Authors** | Masatoshi SEKI, Takashi Kokubun |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.2.0 |

An easy to use but powerful templating system for Ruby.

## [erb_lint](https://github.com/Shopify/erb_lint)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Justin Chan, Shopify Developers |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

ERB lint tool

ERB Linter tool.

**Dependencies:** activesupport (>= 0), better_html (>= 2.0.1), parser (>= 2.7.1.4), rainbow (>= 0), rubocop (>= 1), smart_properties (>= 0)

## [error_highlight](https://github.com/ruby/error_highlight)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | Yusuke Endoh |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Shows a one-line code snippet with an underline in the error backtrace

The gem enhances Exception#message by adding a short explanation where the exception is raised

## [erubi](https://github.com/jeremyevans/erubi)

| | |
|---|---|
| **Version** | 1.13.1 |
| **Authors** | Jeremy Evans, kuwata-lab.com |
| **License** | MIT |

Small ERB Implementation

Erubi is a ERB template engine for ruby. It is a simplified fork of Erubis

## [erubis](http://www.kuwata-lab.com/erubis/)

| | |
|---|---|
| **Version** | 2.7.0 |
| **Authors** | makoto kuwata |

a fast and extensible eRuby implementation which supports multi-language

Erubis is an implementation of eRuby and has the following features:  * Very fast, almost three times faster than ERB and about 10% faster than eruby. * Multi-language support (Ruby/PHP/C/Java/Scheme/Perl/Javascript) * Auto escaping support * Auto trimming spaces around '<% %>' * Embedded pattern changeable (default '<% %>') * Enable to handle Processing Instructions (PI) as embedded pattern (ex. '<?rb ... ?>') * Context object available and easy to combine eRuby template with YAML datafile * Print statement available * Easy to extend and customize in subclass * Ruby on Rails support

## [esquema](https://github.com/sergiobayona/esquema)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Sergio Bayona |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Generate json-schema from ActiveRecord models.

**Dependencies:** activerecord (~> 7.1)

## [et-orbi](https://github.com/floraison/et-orbi)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | John Mettraux |
| **License** | MIT |

time with zones

Time zones for fugit and rufus-scheduler. Urbi et Orbi.

**Dependencies:** tzinfo (>= 0)

## [etc](https://github.com/ruby/etc)

| | |
|---|---|
| **Version** | 1.4.6 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Provides access to information typically stored in UNIX /etc directory.

## [etcd](https://github.com/ranjib/etcd-ruby)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Ranjib Dey |
| **License** | MIT |
| **Ruby** | >= 1.9 |

Ruby client library for etcd

**Dependencies:** mixlib-log (>= 0)

## [etcd-discovery](http://github.com/Scalingo/etcd-discovery-ruby)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Léo Unbekandt |
| **License** | BSD |
| **Ruby** | >= 2.7.0 |

Service discovery based on etcd

Ruby implementation of a service discovery tool based on etcd

**Dependencies:** etcd (>= 0)

## [etcher](https://alchemists.io/projects/etcher)

| | |
|---|---|
| **Version** | 3.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A monadic configuration loader, transformer, and validator.

**Dependencies:** cogger (~> 1.0), core (~> 2.5), dry-monads (~> 1.9), dry-types (~> 1.7), refinements (~> 13.6), versionaire (~> 14.0), zeitwerk (~> 2.7)

## [ethon](https://github.com/typhoeus/ethon)

| | |
|---|---|
| **Version** | 0.15.0 |
| **Authors** | Hans Hasselberg |
| **License** | MIT |

Libcurl wrapper.

Very lightweight libcurl wrapper.

**Dependencies:** ffi (>= 1.15.0)

## [eu_central_bank](https://github.com/RubyMoney/eu_central_bank)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Shane Emmons |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Calculates exchange rates based on rates from european central bank. Money gem compatible.

This gem reads exchange rates from the european central bank website. It uses it to calculates exchange rates. It is compatible with the money gem

**Dependencies:** bigdecimal (>= 0), nokogiri (~> 1.11), money (~> 7.0)

## [event_bus](http://github.com/kevinrutherford/event_bus)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Kevin Rutherford |

A simple pubsub event bus for Ruby applications

event_bus provides support for application-wide events, without coupling the publishing and subscribing objects or classes to each other

## [event_emitter](http://shokai.github.com/event_emitter)

| | |
|---|---|
| **Version** | 0.2.6 |
| **Authors** | Sho Hashimoto |

Ruby port of EventEmitter from Node.js

## [event_stream_parser](https://github.com/Shopify/event_stream_parser)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Ates Goral |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A spec-compliant event stream parser

## [eventmachine](http://rubyeventmachine.com)

| | |
|---|---|
| **Version** | 1.2.7 |
| **Authors** | Francis Cianfrocca, Aman Gupta |
| **License** | Ruby, GPL-2.0 |

Ruby/EventMachine library

EventMachine implements a fast, single-threaded engine for arbitrary network communications. It's extremely easy to use in Ruby. EventMachine wraps all interactions with IP sockets, allowing programs to concentrate on the implementation of network protocols. It can be used to create both network servers and clients. To create a server or client, a Ruby program only needs to specify the IP address and port, and provide a Module that implements the communications protocol. Implementations of several standard network protocols are provided with the package, primarily to serve as examples. The real goal of EventMachine is to enable programs to easily interface with other programs using TCP/IP, especially if custom protocols are required.

## [every_day_irb](https://github.com/janlelis/every_day_irb)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.0 |

EveryDayIrb simplifies daily life in IRB.

EveryDayIrb simplifies daily life in IRB with commands like: ls, cat, rq, rrq, ld, reset!, ...

**Dependencies:** irb (>= 0), cd (~> 1.0)

## [evil-seed](https://github.com/palkan/evil-seed)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Andrey Novikov, Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Create partial and anonymized production database dumps for use in development

This gem allows you to easily dump and transform subset of your ActiveRecord models and their relations.

**Dependencies:** activerecord (>= 5.0)

## [evolvable](https://github.com/mattruzicka/evolvable)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Matt Ruzicka |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Add evolutionary behavior to any Ruby object

## [exa-ai](https://github.com/benjaminjackson/exa-ruby)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | Benjamin Jackson |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby client for the Exa.ai API

A Ruby gem for interacting with the Exa.ai search and discovery API

**Dependencies:** faraday (~> 2.0), ld-eventsource (~> 2.0), toon-ruby (~> 0.1)

## [excon](https://github.com/excon/excon)

| | |
|---|---|
| **Version** | 0.112.0 |
| **Authors** | dpiddy (Dan Peterson), geemus (Wesley Beary), nextmat (Matt Sanders) |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

speed, persistence, http(s)

EXtended http(s) CONnections

## [execjs](https://github.com/rails/execjs)

| | |
|---|---|
| **Version** | 2.10.0 |
| **Authors** | Sam Stephenson, Josh Peek |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Run JavaScript code from Ruby

ExecJS lets you run JavaScript code from Ruby.

## [exeggutor](https://github.com/michaeleisel/Exeggutor)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | Michael Eisel |
| **License** | MIT |

A Simple, Capable, and Unified Interface for Running Subprocesses in Ruby

## [extpp](https://github.com/red-data-tools/extpp)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Kouhei Sutou |
| **License** | BSD-2-Clause |

Ext++ is a Ruby extension that provides C++ API for writing Ruby extension.

You can write your Ruby extension easier than Ruby's C API. Because Ext++'s C++ API reduces duplicated code needed for Ruby's C API.

## [extralite](https://github.com/digital-fabric/extralite)

| | |
|---|---|
| **Version** | 2.14 |
| **Authors** | Sharon Rosner |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Extra-lightweight SQLite3 wrapper for Ruby

## [facets](http://rubyworks.github.com/facets)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Thomas Sawyer |
| **License** | BSD-2-Clause |

The orginal well curated collection of extension methods for Ruby.

Facets is the premier collection of extension methods for the Ruby programming language. Facets extensions are unique by virtue of thier atomicity. They are stored in individual files allowing for highly granular control of requirements. In addition, Facets includes a few additional classes and mixins suitable to wide variety of applications.

## [fact_db](https://github.com/MadBomber/fact_db)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Temporal fact tracking with entity resolution and audit trails

FactDb implements the Event Clock concept - capturing organizational reasoning through temporal facts with validity periods (valid_at/invalid_at), entity resolution, and audit trails back to source content. Built on PostgreSQL with pgvector support for semantic search.

**Dependencies:** activerecord (>= 7.0), pg (>= 1.5), neighbor (>= 0.3), myway_config (~> 0.1.1), chronic (>= 0.10), simple_flow (>= 0.2)

## [factbook](https://github.com/factbook/factbook)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

factbook - umbrella - all together incl. factbook readers, writers 'n' importers

**Dependencies:** factbook-readers (>= 0)

## [factbook-codes](https://github.com/factbook/factbook)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

factbook-codes -  world factbook country codes (by region, by category, etc.)

**Dependencies:** logutils (>= 0), csvreader (>= 0)

## [factbook-fields](https://github.com/factbook/factbook)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

factbook-fields - world factbook country profile meta data - categories, fields, subfields, and more

**Dependencies:** factbook-codes (>= 0)

## [factbook-readers](https://github.com/factbook/factbook)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

factbook-readers - turn thee world factbook country profile pages into open structured data e.g JSON

**Dependencies:** factbook-codes (>= 0), factbook-fields (>= 0), webget (>= 0)

## [factory_bot](https://github.com/thoughtbot/factory_bot)

| | |
|---|---|
| **Version** | 6.5.6 |
| **Authors** | Josh Clayton, Joe Ferris |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

factory_bot provides a framework and DSL for defining and using model instance factories.

factory_bot provides a framework and DSL for defining and using factories - less error-prone, more explicit, and all-around easier to work with than fixtures.

**Dependencies:** activesupport (>= 6.1.0)

## [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)

| | |
|---|---|
| **Version** | 6.5.1 |
| **Authors** | Joe Ferris |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

factory_bot_rails provides integration between factory_bot and Rails 6.1 or newer

**Dependencies:** factory_bot (~> 6.5), railties (>= 6.1.0)

## [faiss](https://github.com/ankane/faiss-ruby)

| | |
|---|---|
| **Version** | 0.5.2 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Efficient similarity search and clustering for Ruby

**Dependencies:** rice (>= 4.8), numo-narray (>= 0)

## [fakefs](https://github.com/fakefs/fakefs)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Chris Wanstrath, Scott Taylor, Jeff Hodges, Pat Nakajima, Brian Donovan |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A fake filesystem. Use it in your tests.

## [faker](https://github.com/faker-ruby/faker)

| | |
|---|---|
| **Version** | 3.6.0 |
| **Authors** | Benjamin Curtis, Vitor Oliveira |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Easily generate fake data

Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.

**Dependencies:** i18n (>= 1.8.11, < 2)

## [faktory_worker_ruby](https://github.com/contribsys/faktory_worker_ruby)

| | |
|---|---|
| **Version** | 2.1.2 |
| **Authors** | Mike Perham |
| **License** | LGPL-3.0 |
| **Ruby** | >= 2.7.0 |

Ruby worker for Faktory

Ruby worker for Faktory.

**Dependencies:** connection_pool (~> 2.5)

## [falcon](https://github.com/socketry/falcon)

| | |
|---|---|
| **Version** | 0.54.1 |
| **Authors** | Samuel Williams, dependabot[bot], Janko Marohnić, Bryan Powell, Trevor Turk, Claudiu Garba, Kyle Tam, Mitsutaka Mimura, Peter Schrammel, Sho Ito, Adam Daniels, Colby Swandale, Daniel Evans, Ismael Celis, Jared Smith, Kent Gruber, Martin Hrdlicka, Michael Adams, Mikel Kew, Nick Janetakis, Olle Jonsson, Pierre Montelle, Santiago Bartesaghi, Sh Lin, Stefan Buhrmester, Tad Thorley, Tasos Latsas, Yoji Shidara |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A fast, asynchronous, rack-compatible web server.

**Dependencies:** async (>= 0), async-container (~> 0.20), async-container-supervisor (~> 0.6), async-http (~> 0.75), async-http-cache (~> 0.4), async-service (~> 0.16), bundler (>= 0), localhost (~> 1.1), openssl (>= 3.0), protocol-http (~> 0.31), protocol-rack (~> 0.7), samovar (~> 2.3)

## [falcon-rails](https://github.com/socketry/falcon-rails)

| | |
|---|---|
| **Version** | 0.2.4 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Easy Falcon and Rails integration.

**Dependencies:** async-cable (>= 0), async-job-adapter-active_job (>= 0), async-websocket (>= 0), bake (>= 0), console-adapter-rails (>= 0), falcon (>= 0), live (>= 0), rails (>= 8.0)

## [fancy_irb](https://github.com/janlelis/fancy_irb)

| | |
|---|---|
| **Version** | 2.1.3 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 3.0, < 5.0 |

Colors and rockets in IRB

A fancy IRB has rocket-style #=> return values and colorful prompts and streams.

**Dependencies:** paint (>= 0.9, < 3.0), irb (>= 1.7, < 2.0), unicode-display_width (>= 2.5)

## [faraday](https://lostisland.github.io/faraday)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | @technoweenie, @iMacTia, @olleolleolle |
| **License** | MIT |
| **Ruby** | >= 2.4 |

HTTP/REST API client library.

**Dependencies:** faraday-em_http (~> 1.0), faraday-em_synchrony (~> 1.0), faraday-excon (~> 1.1), faraday-httpclient (~> 1.0.1), faraday-net_http (~> 1.0), faraday-net_http_persistent (~> 1.1), faraday-patron (~> 1.0), faraday-rack (~> 1.0), multipart-post (>= 1.2, < 3), ruby2_keywords (>= 0.0.4)

## [faraday-em_http](https://github.com/lostisland/faraday-em_http)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | @iMacTia |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for Em::Http

## [faraday-em_synchrony](https://github.com/lostisland/faraday-em_synchrony)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | @iMacTia |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for EM::Synchrony

## [faraday-excon](https://github.com/lostisland/faraday-excon)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | @iMacTia |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for Excon

## [faraday-follow_redirects](https://github.com/tisba/faraday-follow-redirects)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Sebastian Cohnen |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Faraday 1.x and 2.x compatible extraction of FaradayMiddleware::FollowRedirects

Faraday 1.x and 2.x compatible extraction of FaradayMiddleware::FollowRedirects.

**Dependencies:** faraday (>= 1, < 3)

## [faraday-http-cache](https://github.com/sourcelevel/faraday-http-cache)

| | |
|---|---|
| **Version** | 2.6.1 |
| **Authors** | Lucas Mazza, George Guimarães, Gustavo Araujo |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.2.0 |

A Faraday middleware that stores and validates cache expiration.

Middleware to handle HTTP caching

**Dependencies:** faraday (>= 0.8)

## [faraday-httpclient](https://github.com/lostisland/faraday-httpclient)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | @iMacTia |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for HTTPClient

## [faraday-mashify](https://github.com/sue445/faraday-mashify)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | sue445 |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Faraday middleware for wrapping responses into Hashie::Mash

Faraday middleware for wrapping responses into Hashie::Mash.

**Dependencies:** faraday (~> 2.0), hashie (>= 0)

## [faraday-multipart](https://github.com/lostisland/faraday-multipart)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Mattia Giuffrida |
| **License** | MIT |
| **Ruby** | >= 2.4 |

Perform multipart-post requests using Faraday.

**Dependencies:** multipart-post (~> 2.0)

## [faraday-net_http](https://github.com/lostisland/faraday-net_http)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Jan van der Pas |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for Net::HTTP

## [faraday-net_http_persistent](https://github.com/lostisland/faraday-net_http_persistent)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Mike Rogers |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for NetHttpPersistent

## [faraday-patron](https://github.com/lostisland/faraday-patron)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | @iMacTia |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for Patron

## [faraday-rack](https://github.com/lostisland/faraday-rack)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | @iMacTia |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Faraday adapter for Rack

## [faraday-retry](https://github.com/lostisland/faraday-retry)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Mattia Giuffrida |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Catches exceptions and retries each request a limited number of times

Catches exceptions and retries each request a limited number of times.

**Dependencies:** faraday (~> 2.0)

## [faraday-typhoeus](https://github.com/dleavitt/faraday-typhoeus)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Daniel Leavitt |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Faraday adapter for Typhoeus

**Dependencies:** faraday (~> 2.0), typhoeus (~> 1.4)

## [faraday_hal_middleware](https://github.com/fetch/faraday_hal_middleware)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Koen Punt |
| **License** | MIT |

Faraday Middleware for JSON HAL requests and responses.

**Dependencies:** faraday (~> 2.0)

## [faraday_middleware](https://github.com/lostisland/faraday_middleware)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Erik Michaels-Ober, Wynn Netherland |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Various middleware for Faraday

**Dependencies:** faraday (~> 1.0)

## [fast-mcp](https://github.com/yjacquin/fast_mcp)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Yorick Jacquin |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A Ruby implementation of the Model Context Protocol.

A flexible and powerful implementation of the MCP with multiple approaches for defining tools.

**Dependencies:** addressable (~> 2.8), base64 (>= 0), dry-schema (~> 1.14), json (~> 2.0), mime-types (~> 3.4), rack (>= 2.0, < 4.0)

## [fast-mcp-annotations](https://github.com/parruda/fast-mcp)

| | |
|---|---|
| **Version** | 1.5.3 |
| **Authors** | Yorick Jacquin |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A Ruby implementation of the Model Context Protocol. Forked from yjacquin/fast_mcp to add annotations.

A flexible and powerful implementation of the MCP with multiple approaches for defining tools. Forked from yjacquin/fast_mcp to add annotations.

**Dependencies:** addressable (~> 2.8), base64 (>= 0), dry-schema (~> 1.14), json (~> 2.0), mime-types (~> 3.4), rack (< 3)

## [fast-stemmer](http://github.com/romanbsd/fast-stemmer)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Roman Shterenzon |

Fast Porter stemmer based on a C version of algorithm

## [fast_blank](https://github.com/SamSaffron/fast_blank)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Sam Saffron |
| **License** | MIT |

Fast String blank? implementation

Provides a C-optimized method for determining if a string is blank

## [fast_excel](https://github.com/paxa/fast_excel)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Pavel Evstigneev |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Ultra Fast Excel Writer

Wrapper for libxlsxwriter using ffi

**Dependencies:** ffi (> 1.9, < 2)

## [fast_jsonparser](https://github.com/anilmaurya/fast_jsonparser)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Anil Maurya |
| **License** | MIT |

Fast Json Parser

## [fast_resize](https://github.com/tranhuucanh/fast_resize)

| | |
|---|---|
| **Version** | 1.0.7 |
| **Authors** | Tran Huu Canh (0xTh3OKrypt) |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.5.0 |

The fastest image resizing library on the planet.

Resize 1,000 images in 2 seconds. Up to 2.9x faster than libvips, 3.1x faster than imageflow. Uses 3-4x less RAM than alternatives.

## [fastembed](https://github.com/khasinski/fastembed-rb)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Chris Hasinski |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Fast, lightweight text embeddings for Ruby

A Ruby port of FastEmbed - fast text embeddings using ONNX Runtime

**Dependencies:** onnxruntime (~> 0.9), tokenizers (~> 0.5)

## [fastimage](http://github.com/sdsykes/fastimage)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Stephen Sykes |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

FastImage - Image info fast

FastImage finds the size or type of an image given its uri by fetching as little as needed.

## [fasttext](https://github.com/ankane/fastText-ruby)

| | |
|---|---|
| **Version** | 0.4.1 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Efficient text classification and representation learning for Ruby

**Dependencies:** rice (>= 4.7)

## [fattr](https://github.com/ahoward/fattr)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Ara T. Howard |
| **License** | Ruby |

fattr

a "fatter attr" for ruby

## [faye-websocket](https://github.com/faye/faye-websocket-ruby)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | James Coglan |
| **License** | Apache-2.0 |

Standards-compliant WebSocket server and client

**Dependencies:** eventmachine (>= 0.12.0), websocket-driver (>= 0.8.0)

## [fcntl](https://github.com/ruby/fcntl)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Loads constants defined in the OS fcntl.h C header file

## [feature_toggles](https://github.com/bibendi/feature_toggles)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Michael Merkushin |
| **License** | MIT |
| **Ruby** | > 2.5 |

This gem provides a mechanism for pending features.

## [feedbag](http://github.com/damog/feedbag)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | David Moreno |
| **License** | MIT |

RSS/Atom feed auto-discovery tool

Ruby's favorite feed auto-discovery tool

**Dependencies:** nokogiri (~> 1.8, >= 1.8.2), addressable (~> 2.8)

## [feedjira](https://github.com/feedjira/feedjira)

| | |
|---|---|
| **Version** | 4.0.1 |
| **Authors** | Adam Hess, Akinori Musha, Ezekiel Templin, Jon Allured, Julien Kirch, Michael Stock, Paul Dix |
| **License** | MIT |
| **Ruby** | >= 3.1 |

A feed parsing library

**Dependencies:** logger (>= 1.0, < 2), loofah (>= 2.3.1, < 3), sax-machine (>= 1.0, < 2)

## [ferrum](https://github.com/rubycdp/ferrum)

| | |
|---|---|
| **Version** | 0.17.1 |
| **Authors** | Dmitry Vorotilin |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Ruby headless Chrome driver

Ferrum allows you to control headless Chrome browser

**Dependencies:** addressable (~> 2.5), base64 (~> 0.2), concurrent-ruby (~> 1.1), webrick (~> 1.7), websocket-driver (~> 0.7)

## [ferrum-mcp](https://github.com/Eth3rnit3/FerrumMCP)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Eth3rnit3 |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Browser automation server implementing the Model Context Protocol

FerrumMCP is a browser automation server that implements the Model Context Protocol (MCP), enabling AI assistants to interact with web pages through a standardized interface. Features include navigation, form interaction, content extraction, screenshot capture, JavaScript execution, cookie management, and advanced capabilities like smart cookie banner detection and AI-powered CAPTCHA solving.

**Dependencies:** dotenv (~> 3.1), ferrum (~> 0.17.1), json (~> 2.16), logger (~> 1.7), mcp (~> 0.4.0), puma (~> 7.1), rack (~> 3.2), ruby-vips (~> 2.2), zeitwerk (~> 2.7)

## [ferrum_pdf](https://github.com/excid3/ferrum_pdf)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Chris Oliver |
| **License** | MIT |

PDFs & screenshots for Rails using Ferrum & headless Chrome

Export PDFs & screenshots from HTML in Rails using Ferrum & headless Chrome

**Dependencies:** actionpack (>= 6.0.0), ferrum (~> 0.15)

## [festive_errors](https://github.com/honeybadger-io/festive_errors)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | Joshua Wood |
| **License** | MIT |

Add some year-round holiday cheer to the Rails error page.

Festive Errors is a Rails gem that spices up the Rails error page with fun holiday themes. We all like to do a little coding around the holidays. Get into the holiday spirit with Festive Errors!

**Dependencies:** rails (>= 7.0.0)

## [ffi](https://github.com/ffi/ffi/wiki)

| | |
|---|---|
| **Version** | 1.17.3 |
| **Authors** | Wayne Meissner |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.0, < 4.1.dev |

Ruby FFI

Ruby FFI library

## [ffi-compiler](https://github.com/ffi/ffi-compiler)

| | |
|---|---|
| **Version** | 1.3.2 |
| **Authors** | Wayne Meissner |
| **License** | Apache-2.0 |
| **Ruby** | >= 1.9 |

Ruby FFI Rakefile generator

Ruby FFI library

**Dependencies:** rake (>= 0), ffi (>= 1.15.5)

## [ffi-locale](http://github.com/seanohalpin/ffi-locale)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Sean O'Halpin |

An FFI wrapper for the C library setlocale and localeconv functions.

**Dependencies:** ffi (>= 1.0.9)

## [ffi-ncurses](http://github.com/seanohalpin/ffi-ncurses)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Sean O'Halpin |

An FFI wrapper around ncursesw 5.x for MRI Ruby 1.8.x, 1.9.x and JRuby.

**Dependencies:** ffi (>= 1.0.9), ffi-locale (>= 1.0.0)

## [ffi-rzmq](http://github.com/chuckremes/ffi-rzmq)

| | |
|---|---|
| **Version** | 2.0.7 |
| **Authors** | Chuck Remes |
| **License** | MIT |

This gem wraps the ZeroMQ (0mq) networking library using Ruby FFI (foreign function interface).

This gem wraps the ZeroMQ networking library using the ruby FFI (foreign function interface). It's a pure ruby wrapper so this gem can be loaded and run by any ruby runtime that supports FFI. That's all of the major ones - MRI, Rubinius and JRuby.

**Dependencies:** ffi-rzmq-core (>= 1.0.7)

## [ffi-rzmq-core](http://github.com/chuckremes/ffi-rzmq-core)

| | |
|---|---|
| **Version** | 1.0.7 |
| **Authors** | Chuck Remes |
| **License** | MIT |

This gem provides only the FFI wrapper for the ZeroMQ (0mq) networking library.

This gem provides only the FFI wrapper for the ZeroMQ (0mq) networking library. Project can be used by any other zeromq gems that want to provide their own high-level Ruby API.

**Dependencies:** ffi (>= 0)

## [ffi-yajl](http://github.com/chef/ffi-yajl)

| | |
|---|---|
| **Version** | 2.7.7 |
| **Authors** | Lamont Granquist |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Ruby FFI wrapper around YAJL 2.x

**Dependencies:** libyajl2 (>= 2.1), yajl (>= 0)

## [fiber-annotation](https://github.com/ioquatix/fiber-annotation)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A mechanism for annotating fibers.

## [fiber-local](https://github.com/socketry/fiber-local)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Provides a class-level mixin to make fiber local state easy.

**Dependencies:** fiber-storage (>= 0)

## [fiber-storage](https://github.com/ioquatix/fiber-storage)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Provides a compatibility shim for fiber storage.

## [fiddle](https://github.com/ruby/fiddle)

| | |
|---|---|
| **Version** | 1.1.8 |
| **Authors** | Aaron Patterson, SHIBATA Hiroshi |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

A libffi wrapper for Ruby.

## [file-tail](http://github.com/flori/file-tail)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Florian Frank |
| **License** | Apache-2.0 |

File::Tail for Ruby

Library to tail files in Ruby

**Dependencies:** tins (~> 1.0)

## [filesize](https://github.com/dominikh/filesize)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Dominik Honnef |
| **License** | MIT |
| **Ruby** | >= 1.8.6 |

filesize is a small class for handling filesizes with both the SI and binary prefixes, allowing conversion from any size to any other size.

## [fileutils](https://github.com/ruby/fileutils)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Minero Aoki |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Several file utility methods for copying, moving, removing, etc.

## [filterameter](https://github.com/RockSolt/filterameter)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Todd Kummer |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Declarative Filter Parameters

Declare filters in Rails controllers to increase readability and reduce boilerplate code.

**Dependencies:** rails (>= 6.1)

## [find](https://github.com/ruby/find)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Kazuki Tsujimoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

This module supports top-down traversal of a set of file paths.

## [fission](https://github.com/thbishop/fission)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Tommy Bishop |

Command line tool to manage VMware Fusion VMs

A simple utility to manage VMware Fusion VMs from the command line

**Dependencies:** CFPropertyList (~> 2.2)

## [fixturebot-rails](https://github.com/rubymonolith/fixturebot)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Brad Gessler |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Define Rails fixtures with a Ruby DSL instead of writing YAML by hand

FixtureBot gives you a Ruby DSL that feels like FactoryBot, backed by the speed of Rails fixtures. Define your test data in Ruby and generate standard YAML fixture files.

**Dependencies:** thor (>= 0)

## [flamegraph](https://github.com/SamSaffron/flamegraph)

| | |
|---|---|
| **Version** | 0.9.5 |
| **Authors** | Sam Saffron |
| **License** | MIT |

Flamegraph support for arbitrary ruby apps

## [flay](http://ruby.sadi.st/)

| | |
|---|---|
| **Version** | 2.14.2 |
| **Authors** | Ryan Davis |
| **License** | MIT |

Flay analyzes code for structural similarities

Flay analyzes code for structural similarities. Differences in literal values, variable, class, method names, whitespace, programming style, braces vs do/end, etc are all ignored. Making this totally rad.

**Dependencies:** sexp_processor (~> 4.0), prism (~> 1.7), erubi (~> 1.10), path_expander (~> 2.0)

## [flickwerk](https://github.com/friendlycart/flickwerk)

| | |
|---|---|
| **Version** | 0.3.6 |
| **Authors** | Martin Meyerhoff |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Support for lazy loading patches in Rails engines

**Dependencies:** railties (>= 7.0)

## [flog](http://ruby.sadi.st/)

| | |
|---|---|
| **Version** | 4.9.4 |
| **Authors** | Ryan Davis |
| **License** | MIT |

Flog reports the most tortured code in an easy to read pain report

Flog reports the most tortured code in an easy to read pain report. The higher the score, the more pain the code is in.

**Dependencies:** sexp_processor (~> 4.8), prism (~> 1.7), path_expander (~> 2.0)

## [fmt](https://github.com/hopsoft/fmt)

| | |
|---|---|
| **Version** | 0.3.5 |
| **Authors** | Nate Hopkins (hopsoft) |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

CLI Templating System and String Formatter

**Dependencies:** ast (>= 0)

## [fog-core](https://github.com/fog/fog-core)

| | |
|---|---|
| **Version** | 1.45.0 |
| **Authors** | Evan Light, Wesley Beary |
| **License** | MIT |

Shared classes and tests for fog providers and services.

**Dependencies:** builder (>= 0), excon (~> 0.58), formatador (~> 0.2)

## [fog-json](http://github.com/fog/fog-json)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Wesley Beary (geemus), Paul Thornthwaite (tokengeek), The fog team |
| **License** | MIT |

JSON parsing for fog providers

Extraction of the JSON parsing tools shared between a number of providers in the 'fog' gem.

**Dependencies:** fog-core (>= 0), multi_json (~> 1.10)

## [fog-powerdns](http://github.com/cluobah/fog-powerdns)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Chris Luo |
| **License** | MIT |

Module for the 'fog' gem to support PowerDNS DNS services.

This library can be used as a module for 'fog' or as a standalone provider to use PowerDNS DNS services in applications.

**Dependencies:** fog-core (>= 0), fog-json (>= 0), fog-xml (>= 0)

## [fog-profitbricks](https://github.com/fog/fog-profitbricks)

| | |
|---|---|
| **Version** | 4.1.1 |
| **Authors** | Ethan Devenport |
| **License** | MIT |

Module for the 'fog' gem to support ProfitBricks.

This library can be used as a module for 'fog' or as standalone ProfitBricks provider.

**Dependencies:** fog-core (~> 1.42), fog-json (~> 1.0)

## [fog-rackspace](http://developer.rackspace.com)

| | |
|---|---|
| **Version** | 0.1.6 |
| **Authors** | Matt Darby |
| **License** | MIT |

Rackspace support for Fog

Rackspace provider gem for Fog

**Dependencies:** fog-core (>= 1.35), fog-json (>= 1.0), fog-xml (>= 0.1), ipaddress (>= 0.8)

## [fog-radosgw](https://github.com/fog/fog-radosgw)

| | |
|---|---|
| **Version** | 0.0.5 |
| **Authors** | Jon Kåre Hellan |
| **License** | MIT |

Fog backend for provisioning Ceph Radosgw.

Fog backend for provisioning users on Ceph Radosgw - the Swift and S3 compatible REST API for Ceph.

**Dependencies:** fog-json (>= 0), fog-xml (>= 0.0.1), fog-core (>= 1.21.0)

## [fog-riakcs](https://rubygems.org/gems/fog-riakcs)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |

Module for the 'fog' gem to support Riakcs.

This library can be used as a module for `fog` or as standalone provider to use the Riakcs in applications.

**Dependencies:** fog-core (>= 0), fog-json (>= 0), fog-xml (>= 0)

## [fog-sakuracloud](https://rubygems.org/gems/fog-sakuracloud)

| | |
|---|---|
| **Version** | 1.7.5 |
| **Authors** | sawanoboly |
| **License** | MIT |

Module for the 'fog' gem to support Sakura no Cloud

**Dependencies:** fog-core (>= 0), fog-json (>= 0)

## [fog-serverlove](https://rubygems.org/gems/fog-serverlove)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |

Module for the 'fog' gem to support ServerLove.

This library can be used as a module for `fog` or as standalone provider to use the ServerLove in applications.

**Dependencies:** fog-core (>= 0), fog-json (>= 0)

## [fog-softlayer](https://github.com/fog/fog-softlayer)

| | |
|---|---|
| **Version** | 1.1.4 |
| **Authors** | Matt Eldridge |
| **License** | MIT |

This library can be used as a module for `fog` or as standalone provider to use the SoftLayer Cloud in applications

Module for the 'fog' gem to support SoftLayer Cloud

**Dependencies:** fog-core (>= 0), fog-json (>= 0)

## [fog-storm_on_demand](https://rubygems.org/gems/fog-storm_on_demand)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |

Module for the 'fog' gem to support StormOnDemand.

This library can be used as a module for `fog` or as standalone provider to use the StormOnDemand in applications.

**Dependencies:** fog-core (>= 0), fog-json (>= 0)

## [fog-terremark](https://rubygems.org/gems/fog-terremark)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |

Module for the 'fog' gem to support Terremark vCloud.

This library can be used as a module for `fog` or as standalone provider to use the Terremark vCloud in applications.

**Dependencies:** fog-core (>= 0), fog-xml (>= 0)

## [fog-vmfusion](https://rubygems.org/gems/fog-vmfusion)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |

Module for the 'fog' gem to support VMWARE FUSION.

This library can be used as a module for `fog` or as standalone provider to use the VMWARE FUSION in applications.

**Dependencies:** fog-core (>= 0), fission (>= 0)

## [fog-voxel](https://rubygems.org/gems/fog-voxel)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |

Module for the 'fog' gem to support Voxel.

This library can be used as a module for `fog` or as standalone provider to use the Voxel in applications.

**Dependencies:** fog-core (>= 0), fog-xml (>= 0)

## [fog-vsphere](https://github.com/fog/fog-vsphere)

| | |
|---|---|
| **Version** | 3.7.2 |
| **Authors** | J.R. Garcia |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Module for the 'fog' gem to support VMware vSphere.

This library can be used as a module for `fog` or as standalone provider to use vSphere in applications.

**Dependencies:** fog-core (>= 0), rbvmomi2 (~> 3.0)

## [fog-xenserver](https://github.com/fog/fog-xenserver)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Paulo Henrique Lopes Ribeiro |
| **License** | MIT |
| **Ruby** | >= 2.0 |

This library can be used as a module for `fog` or as standalone provider to use the XENSERVER in applications.

Module for the 'fog' gem to support XENSERVER.

**Dependencies:** fog-xml (>= 0), fog-core (>= 0), xmlrpc (>= 0)

## [fog-xml](https://github.com/fog/fog-xml)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | Wesley Beary (geemus), Paul Thornthwaite (tokengeek), The fog team |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

XML parsing for fog providers

Extraction of the XML parsing tools shared between a number of providers in the 'fog' gem

**Dependencies:** fog-core (>= 0), nokogiri (>= 1.5.11, < 2.0.0)

## [font-awesome-rails](https://github.com/bokmann/font-awesome-rails)

| | |
|---|---|
| **Version** | 4.7.0.9 |
| **Authors** | bokmann |
| **License** | MIT, SIL Open Font License |
| **Ruby** | >= 1.9.3 |

an asset gemification of the font-awesome icon font library

font-awesome-rails provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.

**Dependencies:** railties (>= 3.2, < 9.0)

## [foreman](https://github.com/ddollar/foreman)

| | |
|---|---|
| **Version** | 0.90.0 |
| **Authors** | David Dollar |
| **License** | MIT |

Process manager for applications with multiple components

**Dependencies:** thor (~> 1.4)

## [form_props](https://github.com/thoughtbot/form_props/)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Johny Ho |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Form props is a Rails form builder that renders form attributes in JSON

**Dependencies:** activesupport (>= 7.0, < 9.0), actionview (>= 7.0, < 9.0), props_template (>= 0.30.0)

## [formatador](https://github.com/geemus/formatador)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | geemus (Wesley Beary) |
| **License** | MIT |

Ruby STDOUT text formatting

STDOUT text formatting

## [forwardable](https://github.com/ruby/forwardable)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Keiju ISHITSUKA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.4.0 |

Provides delegation of specified methods to a designated object.

## [forwardable-extended](http://github.com/envygeeks/forwardable-extended)

| | |
|---|---|
| **Version** | 2.6.0 |
| **Authors** | Jordon Bedwell |
| **License** | MIT |

Forwardable with hash, and instance variable extensions.

## [freyia](https://codeberg.org/jaredwhite/freyia)

| | |
|---|---|
| **Version** | 0.6.2 |
| **Authors** | Jared White |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Define and execute automated tasks like the party girl you are.

## [front_matter_parser](https://github.com/waiting-for-dev/front_matter_parser)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | marc |
| **License** | LGPL3 |

Library to parse a front matter from strings or files. It allows writing syntactically correct source files, marking front matters as comments in the source file language.

Parse a front matter from syntactically correct strings or files

## [fugit](https://github.com/floraison/fugit)

| | |
|---|---|
| **Version** | 1.12.1 |
| **Authors** | John Mettraux |
| **License** | MIT |

time tools for flor

Time tools for flor and the floraison project. Cron parsing and occurrence computing. Timestamps and more.

**Dependencies:** raabro (~> 1.4), et-orbi (~> 1.4)

## [fuubar](https://github.com/thekompanee/fuubar)

| | |
|---|---|
| **Version** | 2.5.1 |
| **Authors** | Nicholas Evans, Jeff Kreeftmeijer, jfelchner |
| **License** | MIT |

the instafailing RSpec progress bar formatter

**Dependencies:** rspec-core (~> 3.0), ruby-progressbar (~> 1.4)

## [fuzzyurl](https://github.com/gamache/fuzzyurl.rb)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Pete Gamache |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

A library for non-strict parsing, construction, and wildcard-matching of URLs.

## [fx](https://github.com/teoljungberg/fx)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Teo Ljungberg |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Support for database functions and triggers in Rails migrations

Adds methods to ActiveRecord::Migration to create and manage database functions and triggers in Rails

**Dependencies:** activerecord (>= 7.2, < 8.2), railties (>= 7.2, < 8.2)

## [g](http://github.com/jugyo/g)

| | |
|---|---|
| **Version** | 1.7.2 |
| **Authors** | jugyo |

The Kernel.g

It works like Kernel.p with growl :)

## [gapic-common](https://github.com/googleapis/ruby-core-libraries)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Google API Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Common code for GAPIC-generated API clients

**Dependencies:** faraday (>= 1.9, < 3.a), faraday-retry (>= 1.0, < 3.a), googleapis-common-protos (~> 1.6), googleapis-common-protos-types (~> 1.15), googleauth (~> 1.12), google-cloud-env (~> 2.2), google-logging-utils (~> 0.1), google-protobuf (~> 4.26), grpc (~> 1.66)

## [geared_pagination](https://github.com/basecamp/geared_pagination)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Paginate Active Record sets at variable speeds

**Dependencies:** activesupport (>= 5.0), addressable (>= 2.5.0)

## [geek_painter](http://github.com/rafmagana/geek_painter)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Rafael Magana |

A very simple DSL to generate a colored shell prompt string to use in *nix OS terminals

A very simple DSL to generate a colored shell prompt string to use in *nix OS terminals. it might be used to generate a valid string to be used as a prompt or to generated strings that represent colored text on a terminal.

## [gegene](https://github.com/bankair/gegene)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Alexandre Ignjatovic |
| **License** | MIT |

Genetic algorithm helpers

Framework for genetic algorithm fast development

## [gelauto](http://github.com/camertron/gelauto)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Cameron Dutro |

Automatically annotate your code with Sorbet type definitions.

**Dependencies:** parser (~> 3.0), gli (~> 2.0)

## [gemdiff](https://github.com/teeparham/gemdiff)

| | |
|---|---|
| **Version** | 6.0.2 |
| **Authors** | Tee Parham |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Find source repositories for ruby gems. Open, compare, and update outdated gem versions

Command-line utility to find source repositories for ruby gems, open common GitHub pages, compare gem versions, and simplify gem update workflow in git.

**Dependencies:** faraday-retry (~> 2.2), launchy (~> 3.0), octokit (~> 9.0), thor (~> 1.0)

## [gemini-ai](https://github.com/gbaptista/gemini-ai)

| | |
|---|---|
| **Version** | 4.3.0 |
| **Authors** | gbaptista |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Interact with Google's Gemini AI.

A Ruby Gem for interacting with Gemini through Vertex AI, Generative Language API, or AI Studio, Google's generative AI services.

**Dependencies:** event_stream_parser (~> 1.0), faraday (~> 2.13, >= 2.13.2), faraday-typhoeus (~> 1.1), googleauth (~> 1.8), typhoeus (~> 1.4, >= 1.4.1)

## [gemoji](https://github.com/github/gemoji)

| | |
|---|---|
| **Version** | 3.0.1 |
| **Authors** | GitHub |
| **License** | MIT |
| **Ruby** | > 1.9 |

Emoji library

Character information and metadata for standard and custom emoji.

## [gemojione](https://github.com/bonusly/gemojione)

| | |
|---|---|
| **Version** | 4.3.3 |
| **Authors** | Steve Klabnik, Winfield Peterson, Jonathan Wiesel, Allan McLelland |
| **License** | MIT |

A gem for EmojiOne

**Dependencies:** json (>= 0)

## [gems](https://github.com/rubygems/gems)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Erik Michaels-Ober |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Ruby wrapper for the RubyGems.org API

## [gemsmith](https://alchemists.io/projects/gemsmith)

| | |
|---|---|
| **Version** | 24.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A command line interface for smithing Ruby gems.

**Dependencies:** cogger (~> 2.0), containable (~> 2.0), core (~> 3.0), dry-monads (~> 1.9), dry-schema (~> 1.15), etcher (~> 4.0), infusible (~> 5.0), milestoner (~> 20.0), refinements (~> 14.0), rubysmith (~> 9.1), runcom (~> 13.0), sod (~> 2.0), spek (~> 5.0), zeitwerk (~> 2.7)

## [gen-ai](https://github.com/alchaplinsky/gen-ai)

| | |
|---|---|
| **Version** | 0.4.3 |
| **Authors** | Alex Chaplinsky |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Generative AI toolset for Ruby.

GenAI allows you to easily integrate Generative AI model providers like OpenAI, Google Vertex AI, Stability AI, etc

**Dependencies:** activesupport (~> 7.1), faraday (~> 2.7), faraday-multipart (~> 1.0), zeitwerk (~> 2.6)

## [gene_genie](https://github.com/MEHColeman/gene_genie)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Mark Coleman |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Genetic algorithm optimisation gem

Optimise anything that responds to 'fitness' and takes a hash

## [geocoder](http://www.rubygeocoder.com)

| | |
|---|---|
| **Version** | 1.8.6 |
| **Authors** | Alex Reisner |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Complete geocoding solution for Ruby.

Object geocoding (by street or IP address), reverse geocoding (coordinates to street address), distance queries for ActiveRecord and Mongoid, result caching, and more. Designed for Rails but works with Sinatra and other Rack frameworks too.

**Dependencies:** base64 (>= 0.1.0), csv (>= 3.0.0)

## [geospatial](https://github.com/ioquatix/geospatial)

| | |
|---|---|
| **Version** | 1.14.1 |
| **Authors** | Samuel Williams |
| **License** | MIT |

Provides abstractions for dealing with geographical locations efficiently

## [gepub](http://github.com/skoji/gepub)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | KOJIMA Satoshi |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.2 |

a generic EPUB library for Ruby.

gepub is a generic EPUB parser/generator. Generates and parse EPUB2 and EPUB3

**Dependencies:** nokogiri (>= 1.8.2, < 2.0), rubyzip (>= 3.0, < 3.3)

## [get_process_mem](https://github.com/schneems/get_process_mem)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Richard Schneeman |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Use GetProcessMem to find out the amount of RAM used by any process

Get memory usage of a process in Ruby

**Dependencies:** ffi (~> 1.0), bigdecimal (>= 2.0)

## [getimg_client](https://gitlab.com/coeusit/getimg_client)

| | |
|---|---|
| **Version** | 0.1.7 |
| **Authors** | Melvin Sommer |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Client for Getimg API

A Ruby client for interfacing with the Getimg API.

## [getoptlong](https://github.com/ruby/getoptlong)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |

GetoptLong for Ruby

## [ghub](https://alchemists.io/projects/ghub)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A monadic GitHub API client.

**Dependencies:** containable (~> 2.0), dry-monads (~> 1.9), dry-schema (~> 1.15), http (~> 5.3), infusible (~> 5.0), inspectable (~> 1.0), pipeable (~> 2.0), refinements (~> 14.0), zeitwerk (~> 2.7)

## [gimuby](https://frantzmiccoli.github.io/Gimuby)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Frantz Miccoli |
| **License** | MIT |
| **Ruby** | >= 1.8 |

Gimuby: genetic algorithm and island model for Ruby

Implemented for academic purpose, Gimuby is also suitable for teaching purpose. As far as we know this implementation of genetic algorithms is the most advanced available in Ruby for itintegrates an implementation of the island model, reusable patterns for user problem composition and optimal configuration genetic algorithm Gimuby contains the implementation of standard genetic algorithm (named population) and distributed genetic algorithm or island model (named archipelago). The presented archipelago are NOT distributed (nor with threads, processes, or physical machines). However they let the user benefits ofthe leverage they represent to obtain a better solution with the same amount of resources spent. Similar to: AI4R, gga4r and darwinning

## [gio2](https://ruby-gnome.github.io/)

| | |
|---|---|
| **Version** | 4.3.5 |
| **Authors** | The Ruby-GNOME Project Team |
| **License** | LGPL-2.1-or-later |

Ruby/GIO2 is a Ruby binding of gio-2.x.

Ruby/GIO2 provide Ruby binding to a VFS API and useful APIs for desktop applications (such as networking and D-Bus support).

**Dependencies:** fiddle (>= 0), gobject-introspection (= 4.3.5)

## [git](http://github.com/ruby-git/ruby-git)

| | |
|---|---|
| **Version** | 1.14.0 |
| **Authors** | Scott Chacon and others |
| **License** | MIT |
| **Ruby** | >= 2.3 |

An API to create, read, and manipulate Git repositories

The Git Gem provides an API that can be used to create, read, and manipulate Git repositories by wrapping system calls to the `git` binary. The API can be used for working with Git in complex interactions including branching and merging, object inspection and manipulation, history, patch generation and more.

**Dependencies:** addressable (~> 2.8), rchardet (~> 1.8)

## [git-lint](https://alchemists.io/projects/git-lint)

| | |
|---|---|
| **Version** | 10.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A command line interface for linting Git commits.

**Dependencies:** cogger (~> 2.0), containable (~> 2.0), core (~> 3.0), dry-monads (~> 1.9), dry-schema (~> 1.15), etcher (~> 4.0), gitt (~> 5.0), infusible (~> 5.0), refinements (~> 14.0), runcom (~> 13.0), sod (~> 2.0), spek (~> 5.0), tone (~> 3.0), zeitwerk (~> 2.7)

## [github-markup](https://github.com/github/markup)

| | |
|---|---|
| **Version** | 4.0.2 |
| **Authors** | Chris Wanstrath |
| **License** | MIT |

The code GitHub uses to render README.markup

This gem is used by GitHub to render any fancy markup such as Markdown, Textile, Org-Mode, etc. Fork it and add your own!

## [github-pages](https://github.com/github/pages-gem)

| | |
|---|---|
| **Version** | 223 |
| **Authors** | GitHub, Inc. |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Track GitHub Pages dependencies.

Bootstrap the GitHub Pages Jekyll environment locally.

**Dependencies:** jekyll (= 3.9.0), jekyll-sass-converter (= 1.5.2), kramdown (= 2.3.1), kramdown-parser-gfm (= 1.1.0), jekyll-commonmark-ghpages (= 0.1.6), liquid (= 4.0.3), rouge (= 3.26.0), github-pages-health-check (= 1.17.9), jekyll-redirect-from (= 0.16.0), jekyll-sitemap (= 1.4.0), jekyll-feed (= 0.15.1), jekyll-gist (= 1.5.0), jekyll-paginate (= 1.1.0), jekyll-coffeescript (= 1.1.1), jekyll-seo-tag (= 2.7.1), jekyll-github-metadata (= 2.13.0), jekyll-avatar (= 0.7.0), jekyll-remote-theme (= 0.4.3), jekyll-include-cache (= 0.2.1), jemoji (= 0.12.0), jekyll-mentions (= 1.6.0), jekyll-relative-links (= 0.6.1), jekyll-optional-front-matter (= 0.3.2), jekyll-readme-index (= 0.3.0), jekyll-default-layout (= 0.1.4), jekyll-titles-from-headings (= 0.5.3), minima (= 2.5.1), jekyll-swiss (= 1.0.0), jekyll-theme-primer (= 0.6.0), jekyll-theme-architect (= 0.2.0), jekyll-theme-cayman (= 0.2.0), jekyll-theme-dinky (= 0.2.0), jekyll-theme-hacker (= 0.2.0), jekyll-theme-leap-day (= 0.2.0), jekyll-theme-merlot (= 0.2.0), jekyll-theme-midnight (= 0.2.0), jekyll-theme-minimal (= 0.2.0), jekyll-theme-modernist (= 0.2.0), jekyll-theme-slate (= 0.2.0), jekyll-theme-tactile (= 0.2.0), jekyll-theme-time-machine (= 0.2.0), mercenary (~> 0.3), nokogiri (>= 1.12.5, < 2.0), terminal-table (~> 1.4)

## [github-pages-health-check](https://github.com/github/github-pages-health-check)

| | |
|---|---|
| **Version** | 1.17.9 |
| **Authors** | GitHub, Inc. |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

Checks your GitHub Pages site for commons DNS configuration issues

Checks your GitHub Pages site for commons DNS configuration issues.

**Dependencies:** addressable (~> 2.3), dnsruby (~> 1.60), octokit (~> 4.0), public_suffix (>= 3.0, < 5.0), typhoeus (~> 1.3)

## [github_api](http://piotrmurach.github.io/github/)

| | |
|---|---|
| **Version** | 0.19.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Ruby client for the official GitHub API

Ruby client that supports all of the GitHub API methods. It"s build in a modular way, that is, you can either instantiate the whole api wrapper Github.new or use parts of it e.i. Github::Client::Repos.new if working solely with repositories is your main concern. Intuitive query methods allow you easily call API endpoints.

**Dependencies:** addressable (~> 2.4), hashie (~> 3.5, >= 3.5.2), faraday (>= 0.8, < 2), oauth2 (~> 1.0), descendants_tracker (~> 0.0.4)

## [gitingest](https://github.com/davidesantangelo/gitingest)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Davide Santangelo |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Efficiently generate AI prompts from GitHub repositories for code analysis and documentation

Gitingest is a powerful command-line tool that fetches files from GitHub repositories and generates consolidated text prompts for AI analysis. It features smart file filtering, concurrent processing, custom exclusion patterns, authentication support, and automatic rate limit handling. Perfect for creating context-rich prompts from codebases for AI assistants, documentation generation, or codebase analysis.

**Dependencies:** concurrent-ruby (~> 1.1), faraday-retry (~> 2.0), octokit (~> 9.0), optparse (~> 0.1)

## [gitt](https://alchemists.io/projects/gitt)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A monadic Object API for the Git CLI.

**Dependencies:** core (~> 3.0), dry-monads (~> 1.9), refinements (~> 14.0), zeitwerk (~> 2.7)

## [glamour](https://github.com/marcoroth/glamour-ruby)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2, < 4.1.dev |

Ruby wrapper for Charm's glamour. Stylesheet-based markdown rendering for your CLI apps.

Glamour lets you render markdown documents & templates on ANSI compatible terminals.

## [gli](http://davetron5000.github.io/gli)

| | |
|---|---|
| **Version** | 2.22.2 |
| **Authors** | David Copeland |
| **License** | Apache-2.0 |

Build command-suite CLI apps that are awesome.

Build command-suite CLI apps that are awesome.  Bootstrap your app, add commands, options and documentation while maintaining a well-tested idiomatic command-line app

**Dependencies:** ostruct (>= 0)

## [glib2](https://ruby-gnome.github.io/)

| | |
|---|---|
| **Version** | 4.3.5 |
| **Authors** | The Ruby-GNOME Project Team |
| **License** | LGPL-2.1-or-later |

Ruby/GLib2 is a Ruby binding of GLib-2.x.

Ruby/GLib2 provides base features for GLib2 based bindings and many useful utility features.

**Dependencies:** pkg-config (>= 1.3.5), native-package-installer (>= 1.0.3)

## [glimmer](http://github.com/AndyObtiva/glimmer)

| | |
|---|---|
| **Version** | 2.8.1 |
| **Authors** | AndyMaleh |
| **License** | MIT |

Glimmer (DSL Framework for Ruby GUI and More)

Glimmer is a Ruby DSL Framework for Ruby GUI and More, consisting of a DSL Engine and a Data-Binding Library (including Observer Design Pattern, Observable Model, Observable Array, and Observable Hash). Used in Glimmer DSL for SWT (JRuby Desktop Development GUI Framework), Glimmer DSL for Web (Ruby in the Browser Web Frontend Framework and Winner of Fukuoka Prefecture Future IT Initiative 2025 Money Forward Award), Glimmer DSL for LibUI (Prerequisite-Free Ruby Desktop Development GUI Library and Winner of Fukuoka Ruby Award Competition 2022 Special Award), Glimmer DSL for Tk (Ruby Tk Desktop Development GUI Library), Glimmer DSL for GTK (Ruby-GNOME Desktop Development GUI Library), Glimmer DSL for FX (FOX Toolkit Ruby Desktop Development GUI Library), Glimmer DSL for WX (wxWidgets Ruby Desktop Development GUI Library), Glimmer DSL for Swing (JRuby Swing Desktop Development GUI Library), Glimmer DSL for JFX (JRuby JavaFX Desktop Development GUI Library), Glimmer DSL for XML (& HTML), and Glimmer DSL for CSS.

**Dependencies:** array_include_methods (>= 1.4.0, < 1.6.0), facets (>= 3.1.0, < 4.0.0)

## [globalid](http://www.rubyonrails.org)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Refer to any model with a URI: gid://app/class/id

URIs for your models makes it easy to pass references around.

**Dependencies:** activesupport (>= 6.1)

## [gobject-introspection](https://ruby-gnome.github.io/)

| | |
|---|---|
| **Version** | 4.3.5 |
| **Authors** | The Ruby-GNOME Project Team |
| **License** | LGPL-2.1-or-later |

Ruby/GObjectIntrospection is a Ruby binding of GObject Introspection.

Ruby/GObjectIntrospection provides bindings of GObject Introspection and a loader module that can generate dynamically Ruby bindings of any GObject C libraries

**Dependencies:** glib2 (= 4.3.5)

## [gollum](http://github.com/gollum/gollum)

| | |
|---|---|
| **Version** | 6.1.0 |
| **Authors** | Tom Preston-Werner, Rick Olson |
| **License** | MIT |
| **Ruby** | >= 2.6 |

A simple, Git-powered wiki.

A simple, Git-powered wiki with a sweet API and local frontend.

**Dependencies:** rdoc (~> 6), gollum-lib (~> 6.0), kramdown (~> 2.3), kramdown-parser-gfm (~> 1.1.0), rack (>= 3.0), rackup (~> 2.1), sinatra (~> 4.0), sinatra-contrib (~> 4.0), mustache-sinatra (~> 2.0), useragent (~> 0.16.2), gemojione (~> 4.1), octicons (~> 19.0), sprockets (~> 4.1), sprockets-helpers (~> 1.2), rss (~> 0.3), therubyrhino (~> 2.1.0), webrick (~> 1.7), i18n (~> 1.8)

## [gollum-lib](http://github.com/gollum/gollum-lib)

| | |
|---|---|
| **Version** | 6.1.0 |
| **Authors** | Tom Preston-Werner, Rick Olson |
| **License** | MIT |
| **Ruby** | >= 2.4 |

A simple, Git-powered wiki.

A simple, Git-powered wiki with a sweet API and local frontend.

**Dependencies:** gollum-rugged_adapter (~> 3.0), rouge (~> 3.1), nokogiri (~> 1.8), loofah (~> 2.3), github-markup (~> 4.0), gemojione (~> 4.1), twitter-text (= 1.14.7)

## [gollum-rugged_adapter](https://github.com/gollum/rugged_adapter)

| | |
|---|---|
| **Version** | 3.0 |
| **Authors** | Bart Kamphorst, Dawa Ometto |
| **License** | MIT |

Adapter for Gollum to use Rugged (libgit2) at the backend.

**Dependencies:** rugged (~> 1.5), mime-types (~> 3.4)

## [gon](https://github.com/gazay/gon)

| | |
|---|---|
| **Version** | 7.0.0 |
| **Authors** | gazay |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

Get your Rails variables in your JS

If you need to send some data to your js files and you don't want to do this with long way trough views and parsing - use this force!

**Dependencies:** actionpack (>= 3.0.20), activesupport (>= 0), i18n (>= 0.7), multi_json (>= 0)

## [gon-sinatra](https://github.com/gazay/gon-sinatra)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | gazay |

Get your Sinatra variables in your JS

If you need to send some data to your js files and you don't want to do this with long way trough views and parsing - use this force!

**Dependencies:** sinatra (>= 0)

## [google-adk](https://github.com/thedayisntgray/google-adk)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Landon Gray |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Unofficial Ruby implementation of Google's Agent Development Kit

UNOFFICIAL Ruby port of Google's Agent Development Kit (ADK). This gem is not affiliated with, endorsed by, or maintained by Google. Build, evaluate, and deploy AI agents using the ADK framework in Ruby.

**Dependencies:** async (~> 2.0), concurrent-ruby (~> 1.2), dotenv (~> 2.8), faraday (~> 2.0), google-cloud-ai_platform-v1 (~> 0.1)

## [google-apis-core](https://github.com/google/google-api-ruby-client)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Common utility and base classes for legacy Google REST clients

**Dependencies:** representable (~> 3.0), retriable (~> 3.1), addressable (~> 2.8, >= 2.8.7), mini_mime (~> 1.1), googleauth (~> 1.14), faraday (~> 2.13), faraday-follow_redirects (~> 0.3)

## [google-apis-iamcredentials_v1](https://github.com/google/google-api-ruby-client)

| | |
|---|---|
| **Version** | 0.26.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Simple REST client for IAM Service Account Credentials API V1

This is the simple REST client for IAM Service Account Credentials API V1. Simple REST clients are Ruby client libraries that provide access to Google services via their HTTP REST API endpoints. These libraries are generated and updated automatically based on the discovery documents published by the service, and they handle most concerns such as authentication, pagination, retry, timeouts, and logging. You can use this client to access the IAM Service Account Credentials API, but note that some services may provide a separate modern client that is easier to use.

**Dependencies:** google-apis-core (>= 0.15.0, < 2.a)

## [google-apis-storage_v1](https://github.com/google/google-api-ruby-client)

| | |
|---|---|
| **Version** | 0.59.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Simple REST client for Cloud Storage JSON API V1

This is the simple REST client for Cloud Storage JSON API V1. Simple REST clients are Ruby client libraries that provide access to Google services via their HTTP REST API endpoints. These libraries are generated and updated automatically based on the discovery documents published by the service, and they handle most concerns such as authentication, pagination, retry, timeouts, and logging. You can use this client to access the Cloud Storage JSON API, but note that some services may provide a separate modern client that is easier to use.

**Dependencies:** google-apis-core (>= 0.15.0, < 2.a)

## [google-cloud-ai_platform-v1](https://github.com/googleapis/google-cloud-ruby)

| | |
|---|---|
| **Version** | 0.64.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Train high-quality custom machine learning models with minimal machine learning expertise and effort.

Vertex AI enables data scientists, developers, and AI newcomers to create custom machine learning models specific to their business needs by leveraging Google's state-of-the-art transfer learning and innovative AI research. Note that google-cloud-ai_platform-v1 is a version-specific client library. For most uses, we recommend installing the main client library google-cloud-ai_platform instead. See the readme for more details.

**Dependencies:** gapic-common (>= 0.25.0, < 2.a), google-cloud-errors (~> 1.0), google-cloud-location (>= 0.7, < 2.a), google-iam-v1 (>= 0.7, < 2.a)

## [google-cloud-core](https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-core)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Mike Moore, Chris Smith |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Internal shared library for google-cloud-ruby

google-cloud-core is the internal shared library for google-cloud-ruby.

**Dependencies:** google-cloud-env (>= 1.0, < 3.a), google-cloud-errors (~> 1.0)

## [google-cloud-env](https://github.com/googleapis/ruby-cloud-env)

| | |
|---|---|
| **Version** | 2.3.1 |
| **Authors** | Daniel Azuma |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Google Cloud Platform hosting environment information.

google-cloud-env provides information on the Google Cloud Platform hosting environment. Applications can use this library to determine hosting context information such as the project ID, whether App Engine is running, what tags are set on the VM instance, and much more.

**Dependencies:** base64 (~> 0.2), faraday (>= 1.0, < 3.a)

## [google-cloud-errors](https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-errors)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Mike Moore, Chris Smith |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Error classes for google-cloud-ruby

google-cloud-errors defines error classes for google-cloud-ruby.

## [google-cloud-location](https://github.com/googleapis/google-cloud-ruby)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

API Client library for the Locations API

An add-on interface used by some Google API clients to provide location management calls.

**Dependencies:** gapic-common (~> 1.2), google-cloud-errors (~> 1.0)

## [google-cloud-storage](https://github.com/googleapis/google-cloud-ruby/tree/master/google-cloud-storage)

| | |
|---|---|
| **Version** | 1.58.0 |
| **Authors** | Mike Moore, Chris Smith |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1.0 |

API Client library for Google Cloud Storage

google-cloud-storage is the official library for Google Cloud Storage.

**Dependencies:** google-cloud-core (~> 1.6), google-apis-core (>= 0.18, < 2), google-apis-iamcredentials_v1 (~> 0.18), google-apis-storage_v1 (>= 0.42), googleauth (~> 1.9), digest-crc (~> 0.4), addressable (~> 2.8), mini_mime (~> 1.0)

## [google-iam-v1](https://github.com/googleapis/google-cloud-ruby)

| | |
|---|---|
| **Version** | 1.5.1 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Manages access control for Google Cloud Platform resources.

An add-on interface used by some Google API clients to provide IAM Policy calls. Note that google-iam-v1 is a version-specific client library. For most uses, we recommend installing the main client library google-iam instead. See the readme for more details.

**Dependencies:** gapic-common (~> 1.2), google-cloud-errors (~> 1.0), grpc-google-iam-v1 (~> 1.11)

## [google-logging-utils](https://github.com/googleapis/ruby-core-libraries)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Google API Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Utility classes for logging to Google Cloud Logging

## [google-protobuf](https://developers.google.com/protocol-buffers)

| | |
|---|---|
| **Version** | 4.33.5 |
| **Authors** | Protobuf Authors |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.1 |

Protocol Buffers

Protocol Buffers are Google's data interchange format.

**Dependencies:** bigdecimal (>= 0), rake (>= 13)

## [google_currency](http://rubymoney.github.com/google_currency)

| | |
|---|---|
| **Version** | 3.4.1 |
| **Authors** | Shane Emmons |
| **License** | MIT |

Access the Google Currency exchange rate data.

GoogleCurrency extends Money::Bank::Base and gives you access to the current Google Currency exchange rates.

**Dependencies:** money (~> 6.7)

## [google_search_results](https://github.com/serpapi/google-search-results-ruby)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | hartator, jvmvik |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

Get Google, Bing, Baidu, Ebay, Yahoo, Yandex, Home depot, Naver, Apple, Duckduckgo, Youtube search results via SerpApi.com

Scape localized search results from search engine using SerpApi.com and returns Hash, JSON, raw HTML

## [google_visualr](https://github.com/winston/google_visualr)

| | |
|---|---|
| **Version** | 2.5.1 |
| **Authors** | Winston Teo |
| **License** | MIT |

A Ruby wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just plain Ruby.

This Ruby gem, GoogleVisualr, is a wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just Ruby; you don't have to write any JavaScript at all.

## [googleapis-common-protos](https://github.com/googleapis/common-protos-ruby)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Common gRPC and protocol buffer classes used in Google APIs

**Dependencies:** googleapis-common-protos-types (~> 1.7), google-protobuf (>= 3.18, < 5.a), grpc (~> 1.41)

## [googleapis-common-protos-types](https://github.com/googleapis/common-protos-ruby)

| | |
|---|---|
| **Version** | 1.22.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Common protocol buffer types used in Google APIs

Common protocol buffer types used by Google APIs

**Dependencies:** google-protobuf (~> 4.26)

## [googleauth](https://github.com/googleapis/google-auth-library-ruby)

| | |
|---|---|
| **Version** | 1.16.1 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Google Auth Library for Ruby

Implements simple authorization for accessing Google APIs, and provides support for Application Default Credentials.

**Dependencies:** faraday (>= 1.0, < 3.a), google-cloud-env (~> 2.2), google-logging-utils (~> 0.1), jwt (>= 1.4, < 4.0), multi_json (~> 1.11), os (>= 0.9, < 2.0), signet (>= 0.16, < 2.a)

## [gosu](https://www.libgosu.org/)

| | |
|---|---|
| **Version** | 1.4.6 |
| **Authors** | Julian Raschke |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

2D game development library.

2D game development library.  Gosu provides simple and game-friendly interfaces to 2D graphics and text (accelerated by 3D hardware), sound samples and music as well as keyboard, mouse and gamepad/joystick input.

## [gpt4all](https://github.com/jaigouk/gpt4all)

| | |
|---|---|
| **Version** | 0.0.5 |
| **Authors** | Jaigouk Kim |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

gpt4all

interface to gpt4all

**Dependencies:** faraday (~> 2.7), os (~> 1.1), tty-progressbar (~> 0.18.2)

## [graphiti](https://github.com/graphiti-api/graphiti)

| | |
|---|---|
| **Version** | 1.10.1 |
| **Authors** | Lee Richmond |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Easily build jsonapi.org-compatible APIs

**Dependencies:** jsonapi-serializable (~> 0.3.0), jsonapi-renderer (~> 0.2, >= 0.2.2), dry-types (>= 0.15.0, < 2.0), graphiti_errors (~> 1.1.0), concurrent-ruby (>= 1.2, < 2.0), activesupport (>= 5.2)

## [graphiti_errors](https://rubygems.org/gems/graphiti_errors)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Lee Richmond |
| **License** | MIT |

Error-handling patterns for JSONAPIs

Handles application errors and model validations

**Dependencies:** jsonapi-serializable (~> 0.1)

## [graphlient](http://github.com/ashkan18/graphlient)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Ashkan Nasseri |
| **License** | MIT |

A friendlier Ruby client for consuming GraphQL-based APIs.

**Dependencies:** faraday (~> 2.0), graphql-client (>= 0)

## [graphlit](https://github.com/OlympiaAI/graphlit)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Obie Fernandez |
| **License** | MIT |
| **Ruby** | >= 3.2.2 |

Ruby SDK Client Library for Graphlit API

## [graphql](https://github.com/rmosolgo/graphql-ruby)

| | |
|---|---|
| **Version** | 1.13.25 |
| **Authors** | Robert Mosolgo |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

A GraphQL language and runtime for Ruby

A plain-Ruby implementation of GraphQL.

**Dependencies:** base64 (>= 0)

## [graphql-client](https://github.com/github-community-projects/graphql-client)

| | |
|---|---|
| **Version** | 0.26.0 |
| **Authors** | GitHub |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

GraphQL Client

A Ruby library for declaring, composing and executing GraphQL queries

**Dependencies:** activesupport (>= 3.0), graphql (>= 1.13.0)

## [graphql_rails](https://github.com/samesystem/graphql_rails)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Povilas Jurčys |
| **License** | MIT |

Rails style structure for GraphQL API.

**Dependencies:** graphql (~> 2), activesupport (>= 4)

## [graphwerk](https://github.com/tricycle/graphwerk)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Samuel Giles |
| **License** | MIT |

Visualise dependencies between your application and it's Packwerk packages using Graphviz.

**Dependencies:** activesupport (>= 0), packwerk (>= 0), ruby-graphviz (>= 0), sorbet-runtime (>= 0)

## [groq](https://github.com/drnic/groq-ruby)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Dr Nic Williams |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Client library for Groq API for fast LLM inference.

**Dependencies:** faraday (>= 1.10.0), json (>= 0), activesupport (> 5), event_stream_parser (~> 1.0)

## [groupdate](https://github.com/ankane/groupdate)

| | |
|---|---|
| **Version** | 6.7.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

The simplest way to group temporal data

**Dependencies:** activesupport (>= 7.1)

## [grpc](https://github.com/google/grpc/tree/master/src/ruby)

| | |
|---|---|
| **Version** | 1.78.0 |
| **Authors** | gRPC Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

GRPC system in Ruby

Send RPCs from Ruby using GRPC

**Dependencies:** google-protobuf (>= 3.25, < 5.0), googleapis-common-protos-types (~> 1.0)

## [grpc-google-iam-v1](https://github.com/googleapis/common-protos-ruby)

| | |
|---|---|
| **Version** | 1.11.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Common protos and gRPC services for Google IAM

**Dependencies:** googleapis-common-protos (~> 1.7.0), google-protobuf (>= 3.18, < 5.a), grpc (~> 1.41)

## [gruff](https://github.com/topfunky/gruff)

| | |
|---|---|
| **Version** | 0.29.0 |
| **Authors** | Geoffrey Grosenbach, Uwe Kubosch |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Beautiful graphs for one or multiple datasets.

Beautiful graphs for one or multiple datasets. Can be used on websites or in documents.

**Dependencies:** rmagick (>= 5.5), bigdecimal (>= 3.0), histogram (>= 0)

## [gssapi](http://github.com/zenchild/gssapi)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Dan Wanek |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

A FFI wrapper around the system GSSAPI library.

A FFI wrapper around the system GSSAPI library. Please make sure and read the Yard docs or standard GSSAPI documentation if you have any questions.  There is also a class called GSSAPI::Simple that wraps many of the common features used for GSSAPI.

**Dependencies:** ffi (>= 1.0.1)

## [gtx](https://github.com/bashly-framework/gtx)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 3.2 |

GTX Template Engine

Create templates that transpile to ERB

**Dependencies:** erb (>= 4.0, < 7)

## [guard](https://github.com/guard/guard)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Thibaud Guillaume-Gentil |

Guard keeps an eye on your file modifications

Guard is a command line tool to easily handle events on file system modifications.

**Dependencies:** thor (~> 0.14.6), ffi (>= 0.5.0)

## [guard-annotate](http://craigjolicoeur.com)

| | |
|---|---|
| **Version** | 2.3 |
| **Authors** | Craig P Jolicoeur |
| **License** | MIT |

Guard gem for annotate

Guard::Annotate automatically runs the annotate gem when needed

**Dependencies:** guard-compat (~> 1.2, >= 1.2.1), annotate (~> 2.4, >= 2.4.0)

## [guard-brakeman](https://github.com/guard/guard-brakeman)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Neil Matatall, Justin Collins |
| **License** | MIT |

Guard gem for Brakeman

Guard::Brakeman automatically scans your Rails app for vulnerabilities using the Brakeman scanner: https://github.com/presidentbeef/brakeman

**Dependencies:** guard (>= 2.0.0), guard-compat (~> 1.0), brakeman (>= 2.1.1)

## [guard-bundler](https://rubygems.org/gems/guard-bundler)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Yann Lugrin |
| **License** | MIT |
| **Ruby** | >= 2.4.9 |

Guard gem for Bundler

Guard::Bundler automatically install/update your gem bundle when needed

**Dependencies:** guard (~> 2.2), guard-compat (~> 1.1), bundler (>= 2.1, < 5)

## [guard-bundler-audit](https://github.com/christianhellsten/guard-bundler-audit)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | Christian Hellsten |
| **License** | MIT |

guard + bundler-audit = security

**Dependencies:** guard (~> 2.0), bundler-audit (>= 0.6.0)

## [guard-chef](http://rubygems.org/gems/guard-chef)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | Dreamr OKelly |

Guard gem for Chef

Guard::Chef allows to automatically & intelligently update roles, cookbooks, and databags for chef.

**Dependencies:** guard (>= 0.2.2)

## [guard-compat](https://rubygems.org/gems/guard-compat)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Cezary Baginski |
| **License** | MIT |

Tools for developing Guard compatible plugins

Helps creating valid Guard plugins and testing them

## [guard-migrate](http://rubygems.org/gems/guard-migrate)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Geoff Lanotte |
| **License** | MIT |

Guard gem for rails migrations

Guard::Migrate automatically runs your database migrations when needed

**Dependencies:** guard (~> 2.3), guard-compat (~> 1.1), activerecord (>= 4.1.0)

## [guard-minitest](https://github.com/guard/guard-minitest)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Yann Lugrin, Rémy Coutable |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Guard plugin for the Minitest framework

Guard::Minitest automatically run your tests with Minitest framework (much like autotest)

**Dependencies:** guard-compat (~> 1.2), minitest (>= 5.0.4, < 7.0)

## [guard-rails_best_practices](http://rubygems.org/gems/guard-rails_best_practices)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Logan Koester |

Guard for rails_best_practices, a code metric tool to check the quality of rails code.

**Dependencies:** guard (>= 0.9), rails_best_practices (>= 1.1.0), activesupport (>= 0)

## [guard-redis](http://rubygems.org/gems/guard-redis)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Zachery Moneypenny |

Guard gem for Redis

Guard::Redis automatically starts and restarts your local redis server.

**Dependencies:** rake (>= 0), guard (~> 2.8), guard-compat (~> 1.2), redis (>= 0)

## [guard-rspec](https://github.com/guard/guard-rspec)

| | |
|---|---|
| **Version** | 4.7.3 |
| **Authors** | Thibaud Guillaume-Gentil |
| **License** | MIT |

Guard gem for RSpec

Guard::RSpec automatically run your specs (much like autotest).

**Dependencies:** guard (~> 2.1), guard-compat (~> 1.1), rspec (>= 2.99.0, < 4.0)

## [guard-rubocop](https://github.com/rubocop/guard-rubocop)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Yuji Nakayama |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Guard plugin for RuboCop

Guard::RuboCop automatically checks Ruby code style with RuboCop when files are modified.

**Dependencies:** guard (~> 2.0), rubocop (< 2.0)

## [guard-rubycritic](https://github.com/whitesmith/guard-rubycritic)

| | |
|---|---|
| **Version** | 2.9.3 |
| **Authors** | Guilherme Simoes |
| **License** | MIT |

Listens to modifications and detects smells in Ruby files

Ruby Critic is a tool that listens to modifications in Ruby classes, modules and methods and reports any new code smells it finds.

**Dependencies:** guard (~> 2.6), rubycritic (>= 2.9.3)

## [guard-s3](http://github.com/guard/guard-s3)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | James Welsh, Austin Mullins |

A simple guard library for syncing files with s3

**Dependencies:** aws-s3 (>= 0), guard (>= 0)

## [guard-shell](http://github.com/sdwolfz/guard-shell)

| | |
|---|---|
| **Version** | 0.7.2 |
| **Authors** | Joshua Hawxwell, Codruț Constantin Gușoi |
| **License** | MIT |

Guard gem for running shell commands

Guard::Shell automatically runs shell commands when watched files are modified.

**Dependencies:** guard (>= 2.0.0), guard-compat (~> 1.0)

## [guard-sidekiq](http://github.com/uken/guard-sidekiq)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Mark Bolusmjak, pitr |

guard gem for sidekiq

Guard::Sidekiq automatically starts/stops/restarts sidekiq worker

**Dependencies:** guard (>= 2), sidekiq (>= 0)

## [gum](https://github.com/marcoroth/gum-ruby)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Ruby wrapper for Charm's gum CLI tool.

Integrate Charm's gum with the RubyGems infrastructure.

## [gutentag](https://github.com/pat/gutentag)

| | |
|---|---|
| **Version** | 3.0.1 |
| **Authors** | Pat Allan |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Good Tags

A good, simple, solid tagging extension for ActiveRecord

**Dependencies:** activerecord (>= 3.2.0)

## [gyoku](https://github.com/savonrb/gyoku)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Daniel Harrington |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

Translates Ruby Hashes to XML

Gyoku translates Ruby Hashes to XML

**Dependencies:** builder (>= 2.1.2), rexml (~> 3.0)

## [hairtrigger](http://github.com/jenseng/hair_trigger)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Jon Jensen |
| **License** | MIT |
| **Ruby** | >= 3.0 |

easy database triggers for active record

allows you to declare database triggers in ruby in your models, and then generate appropriate migrations as they change

**Dependencies:** activerecord (>= 6.0, < 9), ruby_parser (~> 3.10), ruby2ruby (~> 2.4)

## [haml](https://haml.info)

| | |
|---|---|
| **Version** | 7.2.0 |
| **Authors** | Natalie Weizenbaum, Hampton Catlin, Norman Clarke, Akira Matsuda, Takashi Kokubun |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

An elegant, structured (X)HTML/XML templating engine.

**Dependencies:** temple (>= 0.8.2), thor (>= 0), tilt (>= 0)

## [haml-rails](https://github.com/haml/haml-rails)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | André Arko |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

let your Gemfile do the configuring

Haml-rails provides Haml generators for Rails 5.1 and above. It also enables Haml as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah.

**Dependencies:** haml (>= 4.0.6), activesupport (>= 5.1), actionpack (>= 5.1), railties (>= 5.1)

## [hamster](https://github.com/hamstergem/hamster)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Simon Harris |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Efficient, immutable, thread-safe collection classes for Ruby

**Dependencies:** concurrent-ruby (~> 1.0)

## [hana](http://github.com/tenderlove/hana)

| | |
|---|---|
| **Version** | 1.3.7 |
| **Authors** | Aaron Patterson |
| **License** | MIT |

Implementation of [JSON Patch][1] and [JSON Pointer][2] RFC.

## [hanami-view](https://hanamirb.org)

| | |
|---|---|
| **Version** | 2.3.1 |
| **Authors** | Hanakai team |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A complete, standalone view rendering system that gives you everything you need to write well-factored view code

**Dependencies:** dry-configurable (~> 1.0), dry-core (~> 1.0), dry-inflector (~> 1.0, < 2), temple (~> 0.10.0, >= 0.10.2), tilt (~> 2.3), zeitwerk (~> 2.6)

## [handlebars_assets](https://github.com/leshill/handlebars_assets)

| | |
|---|---|
| **Version** | 0.23.9 |
| **Authors** | Les Hill |
| **License** | MIT |

Compile Handlebars templates in the Rails asset pipeline.

A Railties Gem to compile hbs assets

**Dependencies:** execjs (~> 2.0), tilt (>= 1.2), sprockets (>= 2.0.0)

## [harmonica](https://github.com/marcoroth/harmonica-ruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A simple, physics-based animation library for Ruby.

Ruby implementation of Charm's Harmonica. A simple, efficient spring animation library for smooth, natural motion.

## [hash_with_dot_access](https://codeberg.org/jaredwhite/hash_with_dot_access)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Performance-oriented subclass of Hash which provides symbolized keys and method access

## [hashdiff](https://github.com/liufengyun/hashdiff)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Liu Fengyun |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Hashdiff is a diff lib to compute the smallest difference between two hashes.

## [hashery](http://rubyworks.github.com/hashery)

| | |
|---|---|
| **Version** | 2.1.2 |
| **Authors** | Trans, Kirk Haines, Robert Klemme, Jan Molic, George Moschovitis, Jeena Paradies, Erik Veenstra |
| **License** | BSD-2-Clause |

Facets-bread collection of Hash-like classes.

The Hashery is a tight collection of Hash-like classes. Included among its many offerings are the auto-sorting Dictionary class, the efficient LRUHash, the flexible OpenHash and the convenient KeyHash. Nearly every class is a subclass of the CRUDHash which defines a CRUD model on top of Ruby's standard Hash making it a snap to subclass and augment to fit any specific use case.

## [hashie](https://github.com/intridea/hashie)

| | |
|---|---|
| **Version** | 3.6.0 |
| **Authors** | Michael Bleigh, Jerry Cheung |
| **License** | MIT |

Your friendly neighborhood hash library.

Hashie is a collection of classes and mixins that make hashes more powerful.

## [headless](https://github.com/leonid-shevtsov/headless)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Leonid Shevtsov |
| **License** | MIT |

Ruby headless display interface

Headless is a Ruby interface for Xvfb. It allows you to create a headless display straight from Ruby code, hiding some low-level action.

## [heapy](https://github.com/schneems/heapy)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | schneems |
| **License** | MIT |

Inspects Ruby heap dumps

Got a heap dump? Great. Use this tool to see what's in it!

**Dependencies:** thor (>= 0)

## [helicone-rb](https://github.com/genevere-inc/helicone-rb)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Genevere |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Ruby client for Helicone AI Gateway with agentic tool support

A Ruby client that wraps the OpenAI API through the Helicone AI Gateway, providing session tracking, cost attribution, and an agentic framework for building AI applications with tool/function calling.

**Dependencies:** ruby-openai (~> 7.0)

## [herb](https://herb-tools.dev)

| | |
|---|---|
| **Version** | 0.8.9 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.0, < 4.1.dev |

Powerful and seamless HTML-aware ERB parsing and tooling.

## [high_voltage](http://github.com/thoughtbot/high_voltage)

| | |
|---|---|
| **Version** | 5.0.0 |
| **Authors** | Matt Jankowski, Dan Croak, Nick Quaranto, Chad Pytel, Joe Ferris, J. Edward Dewyea, Tammer Saleh, Mike Burns, Tristan Dunn |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Simple static page rendering controller

Fire in the disco. Fire in the ... taco bell.

## [highline](https://github.com/JEG2/highline)

| | |
|---|---|
| **Version** | 3.1.2 |
| **Authors** | James Edward Gray II |
| **License** | Ruby |
| **Ruby** | >= 3.0 |

HighLine is a high-level command-line IO library.

A high-level IO library that provides validation, type conversion, and more for command-line interfaces. HighLine also includes a complete menu system that can crank out anything from simple list selection to complete shells with just minutes of work.

**Dependencies:** reline (>= 0)

## [hightop](https://github.com/ankane/hightop)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A nice shortcut for group count queries

**Dependencies:** activesupport (>= 7.1)

## [hike](http://github.com/sstephenson/hike)

| | |
|---|---|
| **Version** | 2.1.3 |
| **Authors** | Sam Stephenson |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Find files in a set of paths

A Ruby library for finding files in a set of paths.

## [hirb](http://tagaholic.me/hirb/)

| | |
|---|---|
| **Version** | 0.7.3 |
| **Authors** | Gabriel Horner |
| **License** | MIT |

A mini view framework for console/irb that's easy to use, even while under its influence.

Hirb provides a mini view framework for console applications and uses it to improve ripl(irb)'s default inspect output. Given an object or array of objects, hirb renders a view based on the object's class and/or ancestry. Hirb offers reusable views in the form of helper classes. The two main helpers, Hirb::Helpers::Table and Hirb::Helpers::Tree, provide several options for generating ascii tables and trees. Using Hirb::Helpers::AutoTable, hirb has useful default views for at least ten popular database gems i.e. Rails' ActiveRecord::Base. Other than views, hirb offers a smart pager and a console menu. The smart pager only pages when the output exceeds the current screen size. The menu is used in conjunction with tables to offer two dimensional menus.

## [histogram](https://github.com/jtprince/histogram)

| | |
|---|---|
| **Version** | 0.2.4.1 |
| **Authors** | John T. Prince |
| **License** | MIT |

histograms data in different ways

gives objects the ability to 'histogram' in several useful ways

## [hnswlib](https://github.com/yoshoku/hnswlib.rb)

| | |
|---|---|
| **Version** | 0.9.1 |
| **Authors** | yoshoku |
| **License** | Apache-2.0 |

Ruby bindings for the Hnswlib.

Hnswlib.rb provides Ruby bindings for the Hnswlib.

## [hocon](https://github.com/puppetlabs/ruby-hocon)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Chris Price, Wayne Warren, Preben Ingvaldsen, Joe Pinsonault, Kevin Corcoran, Jane Lu |
| **License** | Apache License, v2 |
| **Ruby** | >= 1.9.0 |

HOCON Config Library

== A port of the Java {Typesafe Config}[https://github.com/typesafehub/config] library to Ruby

## [hoe](https://zenspider.com/projects/hoe.html)

| | |
|---|---|
| **Version** | 4.6.0 |
| **Authors** | Ryan Davis |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Hoe is a rake/rubygems helper for project Rakefiles

Hoe is a rake/rubygems helper for project Rakefiles. It helps you manage, maintain, and release your project and includes a dynamic plug-in system allowing for easy extensibility. Hoe ships with plug-ins for all your usual project tasks including rdoc generation, testing, packaging, deployment, and announcement.  See class rdoc for help. Hint: `ri Hoe` or any of the plugins listed below.  For extra goodness, see: https://docs.seattlerb.org/hoe/Hoe.pdf  == Features/Problems:  * Includes a dynamic plug-in system allowing for easy extensibility. * Auto-intuits changes, description, summary, and version. * Uses a manifest for safe and secure deployment. * Provides 'sow' for quick project directory creation. * Sow uses a simple ERB templating system allowing you to capture your project patterns.

**Dependencies:** rake (~> 13.0)

## [holidays](https://github.com/holidays/holidays)

| | |
|---|---|
| **Version** | 8.8.0 |
| **Authors** | Alex Dunae, Phil Peble |
| **License** | MIT |
| **Ruby** | >= 2.4 |

A collection of Ruby methods to deal with statutory and other holidays.

A collection of Ruby methods to deal with statutory and other holidays. You deserve a holiday!

## [honyaku](https://github.com/andrewculver/honyaku)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Andrew Culver |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Translate your Rails application using OpenAI

**Dependencies:** thor (~> 1.3), ruby-openai (~> 6.3), yaml (~> 0.3.0)

## [hotwire-livereload](https://github.com/kirillplatonov/hotwire-livereload)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Kirill Platonov |
| **License** | MIT |

Automatically reload Hotwire Turbo when app files are modified.

**Dependencies:** railties (>= 7.0.0), actioncable (>= 7.0.0), listen (>= 3.0.0)

## [hotwire-spark](https://github.com/hotwired/spark)

| | |
|---|---|
| **Version** | 0.1.13 |
| **Authors** | Jorge Manrubia |
| **License** | MIT |

Smooth live reloading for your Rails apps

A live reloading system that updates just what's needed to offer a smooth experience.

**Dependencies:** rails (>= 7.0.0), zeitwerk (>= 0), listen (>= 0)

## [htm](https://github.com/madbomber/htm)

| | |
|---|---|
| **Version** | 0.0.31 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Hierarchical Temporal Memory for LLM robots

HTM (Hierarchical Temporal Memory) provides intelligent memory/context management for LLM-based applications. It implements a two-tier memory system with durable long-term storage (PostgreSQL) and token-limited working memory, enabling applications to recall context from past conversations using RAG (Retrieval-Augmented Generation) techniques.

**Dependencies:** pg (>= 1.5.0), sequel (>= 5.0), sequel_pg (>= 0), tiktoken_ruby (>= 0), ruby_llm (>= 0), lru_redux (>= 0), ruby-progressbar (>= 0), chronic (>= 0), fast-mcp (>= 0), baran (>= 0), myway_config (>= 0.1.2), simple_flow (>= 0), async (~> 2.0), activesupport (>= 0)

## [html-pipeline](https://github.com/jch/html-pipeline)

| | |
|---|---|
| **Version** | 2.14.3 |
| **Authors** | Ryan Tomayko, Jerry Cheung, Garen J. Torikian |
| **License** | MIT |

Helpers for processing content through a chain of filters

GitHub HTML processing filters and utilities

**Dependencies:** activesupport (>= 2), nokogiri (>= 1.4)

## [htmlbeautifier](http://github.com/threedaymonk/htmlbeautifier)

| | |
|---|---|
| **Version** | 1.4.3 |
| **Authors** | Paul Battley |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

HTML/ERB beautifier

A normaliser/beautifier for HTML that also understands embedded Ruby.

## [htmlentities](https://github.com/threedaymonk/htmlentities)

| | |
|---|---|
| **Version** | 4.3.4 |
| **Authors** | Paul Battley |
| **License** | MIT |

Encode/decode HTML entities

A module for encoding and decoding (X)HTML entities.

## [http](https://github.com/httprb/http)

| | |
|---|---|
| **Version** | 5.3.1 |
| **Authors** | Tony Arcieri, Erik Michaels-Ober, Alexey V. Zapparov, Zachary Anker |
| **License** | MIT |
| **Ruby** | >= 2.6 |

HTTP should be easy

An easy-to-use client library for making requests from Ruby. It uses a simple method chaining system for building requests, similar to Python's Requests.

**Dependencies:** addressable (~> 2.8), http-cookie (~> 1.0), http-form_data (~> 2.2), llhttp-ffi (~> 0.5.0)

## [http-2](https://github.com/igrigorik/http-2)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Tiago Cardoso, Ilya Grigorik, Kaoru Maeda |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Pure-ruby HTTP 2.0 protocol implementation

## [http-accept](https://github.com/ioquatix/http-accept)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Samuel Williams |

Parse Accept and Accept-Language HTTP headers.

## [http-cookie](https://github.com/sparklemotion/http-cookie)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Akinori MUSHA, Aaron Patterson, Eric Hodel, Mike Dalessio |
| **License** | MIT |

A Ruby library to handle HTTP Cookies based on RFC 6265

HTTP::Cookie is a Ruby library to handle HTTP Cookies based on RFC 6265.  It has with security, standards compliance and compatibility in mind, to behave just the same as today's major web browsers.  It has builtin support for the legacy cookies.txt and the latest cookies.sqlite formats of Mozilla Firefox, and its modular API makes it easy to add support for a new backend store.

**Dependencies:** domain_name (~> 0.5)

## [http-form_data](https://github.com/httprb/form_data.rb)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Aleksey V Zapparov |
| **License** | MIT |

http-form_data-2.3.0

Utility-belt to build form data request bodies. Provides support for `application/x-www-form-urlencoded` and `multipart/form-data` types.

## [http_parser.rb](https://github.com/tmm1/http_parser.rb)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Marc-Andre Cournoyer, Aman Gupta |
| **License** | MIT |

Simple callback-based HTTP request/response parser

Ruby bindings to https://github.com/joyent/http-parser and https://github.com/http-parser/http-parser.java

## [httparty](https://github.com/jnunemaker/httparty)

| | |
|---|---|
| **Version** | 0.21.0 |
| **Authors** | John Nunemaker, Sandro Turriate |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Makes http fun! Also, makes consuming restful web services dead easy.

**Dependencies:** multi_xml (>= 0.5.2), mini_mime (>= 1.0.0)

## [httpclient](https://github.com/nahi/httpclient)

| | |
|---|---|
| **Version** | 2.9.0 |
| **Authors** | Hiroshi Nakamura |
| **License** | ruby |

gives something like the functionality of libwww-perl (LWP) in Ruby

**Dependencies:** mutex_m (>= 0)

## [httpi](https://github.com/savonrb/httpi)

| | |
|---|---|
| **Version** | 4.0.4 |
| **Authors** | Daniel Harrington, Martin Tepper |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Common interface for Ruby's HTTP libraries

**Dependencies:** rack (>= 2.0, < 4), nkf (>= 0), base64 (>= 0), mutex_m (>= 0)

## [httplog](http://github.com/trusche/httplog)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Thilo Rusche |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Log outgoing HTTP requests.

Log outgoing HTTP requests made from your application. Helpful for tracking API calls of third party gems that don't provide their own log output.

**Dependencies:** rack (>= 2.0), rainbow (>= 2.0.0), benchmark (>= 0)

## [httpx](https://gitlab.com/os85/httpx)

| | |
|---|---|
| **Version** | 1.7.2 |
| **Authors** | Tiago Cardoso |
| **License** | Apache 2.0 |
| **Ruby** | >= 2.7.0 |

HTTPX, to the future, and beyond

A client library for making HTTP requests from Ruby.

**Dependencies:** http-2 (>= 1.0.0)

## [hugging-face](https://rubygems.org/gems/hugging-face)

| | |
|---|---|
| **Version** | 0.3.5 |
| **Authors** | Alex Chaplinsky |
| **Ruby** | >= 2.6.0 |

Ruby client for Hugging Face API

**Dependencies:** faraday (>= 1.0)

## [hutch](https://github.com/ruby-amqp/hutch)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Harry Marr, Michael Klishin |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Opinionated asynchronous inter-service communication using RabbitMQ

Hutch is a Ruby library for enabling asynchronous inter-service communication using RabbitMQ

**Dependencies:** bunny (>= 2.23, < 3.0), carrot-top (~> 0.0.7), multi_json (~> 1.15), activesupport (>= 4.2)

## [hyll](https://github.com/davidesantangelo/hyll)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Davide Santangelo |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A fast, memory-efficient Ruby implementation of HyperLogLog for counting unique elements in large datasets

Hyll provides a robust implementation of the HyperLogLog algorithm, enabling highly accurate cardinality estimation (counting unique items) with minimal memory footprint. Perfect for analytics, databases, and stream processing where tracking distinct elements in large datasets is required. This implementation offers configurable precision and serialization support.

**Dependencies:** digest (~> 3.1)

## [hyperclient](https://github.com/codegram/hyperclient/)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Oriol Gual |


Hyperclient is a Ruby Hypermedia API client.

**Dependencies:** addressable (>= 0), faraday (>= 2), faraday-follow_redirects (>= 0), faraday_hal_middleware (>= 0.2)

## [hyperclient-mcp](http://github.com/dblock/hyperclient-mcp)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Daniel Doubrovkine |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Turn any Hypermedia api into an mcp server.

**Dependencies:** fast-mcp (>= 0), gli (>= 0), hyperclient (>= 0), puma (>= 0), sinatra (>= 0)

## [i18n](http://github.com/svenfuchs/i18n)

| | |
|---|---|
| **Version** | 0.9.5 |
| **Authors** | Sven Fuchs, Joshua Harvey, Matt Aimonetti, Stephan Soller, Saimon Moore, Ryan Bigg |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

New wave Internationalization support for Ruby

New wave Internationalization support for Ruby.

**Dependencies:** concurrent-ruby (~> 1.0)

## [i18n_data](https://github.com/grosser/i18n_data)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Michael Grosser |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

country/language names and 2-letter-code pairs, in 85 languages

**Dependencies:** simple_po_parser (~> 1.1)

## [ice_cube](https://ice-cube-ruby.github.io/ice_cube/)

| | |
|---|---|
| **Version** | 0.17.0 |
| **Authors** | John Crepezzi |
| **License** | MIT |

Ruby Date Recurrence Library

ice_cube is a recurring date library for Ruby.  It allows for quick, programatic expansion of recurring date rules.

## [ice_nine](https://github.com/dkubb/ice_nine)

| | |
|---|---|
| **Version** | 0.11.2 |
| **Authors** | Dan Kubb |
| **License** | MIT |

Deep Freeze Ruby Objects

## [idn-ruby](http://github.com/deepfryed/idn-ruby)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | Erik Abele, Bharanee Rathna |

LibIDN Ruby Bindings.

Ruby Bindings for the GNU LibIDN library, an implementation of the Stringprep, Punycode and IDNA specifications defined by the IETF Internationalized Domain Names (IDN) working group.  Included are the most important parts of the Stringprep, Punycode and IDNA APIs like performing Stringprep processings, encoding to and decoding from Punycode strings and converting entire domain names to and from the ACE encoded form.

## [image_processing](https://github.com/janko/image_processing)

| | |
|---|---|
| **Version** | 1.14.0 |
| **Authors** | Janko Marohnić |
| **License** | MIT |
| **Ruby** | >= 2.3 |

High-level wrapper for processing images for the web with ImageMagick or libvips.

**Dependencies:** mini_magick (>= 4.9.5, < 6), ruby-vips (>= 2.0.17, < 3)

## [image_size](https://github.com/toy/image_size)

| | |
|---|---|
| **Version** | 3.4.0 |
| **Authors** | Keisuke Minami, Ivan Kuchin |
| **License** | Ruby |
| **Ruby** | >= 1.9.3 |

Measure image size/dimensions using pure Ruby

Measure following file dimensions: apng, avif, bmp, cur, emf, gif, heic, heif, ico, j2c, jp2, jpeg, jpx, mng, pam, pbm, pcx, pgm, png, ppm, psd, svg, swf, tiff, webp, xbm, xpm

## [imagen](https://github.com/grodowski/imagen_rb)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Jan Grodowski |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Codebase as structure of locatable classes and methods based on the Ruby AST

**Dependencies:** parser (>= 2.5, != 2.5.1.1)

## [imgproxy](https://github.com/imgproxy/imgproxy.rb)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Sergei Aleksandrovich |
| **License** | MIT |
| **Ruby** | >= 2.5 |

imgproxy URL generator

A gem that easily generates imgproxy URLs for your images

**Dependencies:** anyway_config (~> 2.6)

## [imgproxy-rails](http://github.com/imgproxy/imgproxy-rails)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Vladimir Dementyev, Albert Pazderin |
| **License** | MIT |
| **Ruby** | >= 2.7 |

integration of imgproxy.rb with ActiveStorage::Variant API

A gem that integrates imgproxy.rb with ActiveStorage::Variant API

**Dependencies:** imgproxy (>= 0), activestorage (>= 6.0)

## [importmap-rails](https://github.com/rails/importmap-rails)

| | |
|---|---|
| **Version** | 2.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Use ESM with importmap to manage modern JavaScript in Rails without transpiling or bundling.

**Dependencies:** railties (>= 6.0.0), activesupport (>= 6.0.0), actionpack (>= 6.0.0)

## [imprint](https://rubygems.org/gems/imprint)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Dan Mayer |
| **License** | MIT |

A gem to help improve logging. Focused on request tracing and cross app tracing.

## [inclusive](https://codeberg.org/jaredwhite/inclusive)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Compose globally-scoped Ruby modules into local packages

## [infobar](https://github.com/flori/infobar)

| | |
|---|---|
| **Version** | 0.13.1 |
| **Authors** | Florian Frank |
| **Ruby** | >= 3.1 |

Gem to display information about computations.

This gem displays progress of computations and additional information to the terminal.

**Dependencies:** tins (~> 1, >= 1.28.0), term-ansicolor (~> 1.11), complex_config (~> 0.22), more_math (>= 0)

## [infusible](https://alchemists.io/projects/infusible)

| | |
|---|---|
| **Version** | 4.6.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

An automatic dependency injector.

**Dependencies:** marameters (~> 4.1)

## [inifile](http://rubygems.org/gems/inifile)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Tim Pease |

INI file reader and writer

Although made popular by Windows, INI files can be used on any system thanks to their flexibility. They allow a program to store configuration data, which can then be easily parsed and changed. Two notable systems that use the INI format are Samba and Trac.  More information about INI files can be found on the [Wikipedia Page](http://en.wikipedia.org/wiki/INI_file).  ### Properties  The basic element contained in an INI file is the property. Every property has a name and a value, delimited by an equals sign *=*. The name appears to the left of the equals sign and the value to the right.  name=value  ### Sections  Section declarations start with *[* and end with *]* as in `[section1]` and `[section2]` shown in the example below. The section declaration marks the beginning of a section. All properties after the section declaration will be associated with that section.  ### Comments  All lines beginning with a semicolon *;* or a number sign *#* are considered to be comments. Comment lines are ignored when parsing INI files.  ### Example File Format  A typical INI file might look like this:  [section1] ; some comment on section1 var1 = foo var2 = doodle var3 = multiline values \ are also possible  [section2] # another comment var1 = baz var2 = shoodle

## [iniparse](http://github.com/antw/iniparse)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Anthony Williams |
| **License** | MIT |

A pure Ruby library for parsing INI documents.

A pure Ruby library for parsing INI documents. Preserves the structure of the original document, including whitespace and comments

## [iniparser](https://github.com/datatxt/iniparser)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

iniparser - read / parse INI configuration, settings and data files into a hash (incl. named subsections)

## [initable](https://alchemists.io/projects/initable)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

An automatic object initializer.

**Dependencies:** marameters (~> 5.0)

## [inline](http://rubyforge.org/projects/inline)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Fabio Cevasco |
| **Ruby** | > 0.0.0 |

A library for definign custom key bindings and perform line editing operations

InLine can be used to define custom key bindings, perform common line editing operations, manage command history and define custom command completion rules.

**Dependencies:** highline (>= 1.4.0)

## [inline_svg](https://github.com/jamesmartin/inline_svg)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | James Martin |
| **License** | MIT |

Embeds an SVG document, inline.

Get an SVG into your view and then style it with CSS.

**Dependencies:** activesupport (>= 3.0), nokogiri (>= 1.6)

## [inspectable](https://alchemists.io/projects/inspectable)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A customizable object inspector.

## [instructor-rb](https://github.com/instructor-ai/instructor-rb)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Sergio Bayona, Jason Liu |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Structured extraction in Ruby, powered by llms.

Explore the power of LLM structured extraction in Ruby with the Instructor gem.

**Dependencies:** activesupport (~> 7.0), easy_talk (~> 0.2), ruby-openai (~> 7)

## [intelligence](https://github.com/EndlessInternational/intelligence)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Kristoph Cichocki-Romanov |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A Ruby gem for seamlessly and uniformly interacting with large languge and vision model (LLM)  API's served by numerous services, including those of OpenAI, Anthropic, Google and others.

Intelligence is a lightweight yet powerful Ruby gem that allows you to seamlessly and uniformly  interact with large language and vision models (LLM) API's of numerous vendors, including  OpenAI, Anthropic, Google, Cerebras, Groq, Hyperbolic, Samba Nova and Together AI. It can be  trivially expanded to other OpenAI conformant API providers as well as self hosted models.  Intelligence supports text models in streaming and non-streaming mode, vision models, and  tool use.    Intelligence has minimal dependencies and does not require the vendors ( often bloated ) SDK's.

**Dependencies:** faraday (~> 2.7), dynamicschema (~> 1.0), mime-types (~> 3.6), json-repair (~> 0.2)

## [interactive_editor](http://github.com/jberkel/interactive_editor)

| | |
|---|---|
| **Version** | 0.0.12 |
| **Authors** | Jan Berkel |
| **License** | MIT |

Interactive editing in irb.

Use vim (or any other text editor) from inside irb to quickly test & write new code.

**Dependencies:** spoon (~> 0.0.6)

## [internator](https://github.com/AlexLarra/internator)

| | |
|---|---|
| **Version** | 0.1.9 |
| **Authors** | AlexLarra |
| **License** | MIT |

CLI tool that automates iterative pull request improvements using OpenAI's Codex

Internator is a Ruby-based CLI tool that automates iterative pull request improvements using OpenAI's Codex. It cycles through objectives, makes incremental changes, automatically commits and pushes each update, and optionally waits between iterations.

## [invoice_printer](https://github.com/strzibny/invoice_printer)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Josef Strzibny |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Super simple PDF invoicing in pure Ruby

Super simple and fast PDF invoicing in pure Ruby (based on Prawn library).

**Dependencies:** json (~> 2.1), prawn (~> 2.4), prawn-table (~> 0.2.2), matrix (>= 0), e2mmap (>= 0), base64 (>= 0)

## [io-console](https://github.com/ruby/io-console)

| | |
|---|---|
| **Version** | 0.8.2 |
| **Authors** | Nobu Nakada |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

Console interface

add console capabilities to IO instances.

## [io-endpoint](https://github.com/socketry/io-endpoint)

| | |
|---|---|
| **Version** | 0.17.2 |
| **Authors** | Samuel Williams, Delton Ding |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provides a separation of concerns interface for IO endpoints.

## [io-event](https://github.com/socketry/io-event)

| | |
|---|---|
| **Version** | 1.14.2 |
| **Authors** | Samuel Williams, Math Ieu, Wander Hillen, Jean Boussier, Benoit Daloze, Bruno Sutic, Shizuo Fujita, Alex Matchneer, Anthony Ross, Delton Ding, Pavel Rosický, Stanislav (Stas) Katkov |
| **License** | MIT |
| **Ruby** | >= 3.2.6 |

An event loop.

## [io-nonblock](https://github.com/ruby/io-nonblock)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Nobu Nakada |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.0 |

Enables non-blocking mode with IO class

## [io-stream](https://github.com/socketry/io-stream)

| | |
|---|---|
| **Version** | 0.11.1 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provides a generic stream wrapper for IO instances.

## [io-wait](https://github.com/ruby/io-wait)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Nobu Nakada, Charles Oliver Nutter |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.2 |

Waits until IO is readable or writable without blocking.

## [iodine](https://github.com/boazsegev/iodine)

| | |
|---|---|
| **Version** | 0.7.58 |
| **Authors** | Boaz Segev |
| **License** | MIT |
| **Ruby** | >= 2.2.2 |

iodine - a fast HTTP / Websocket Server with Pub/Sub support, optimized for Ruby MRI on Linux / BSD / Windows

A fast HTTP / Websocket Server with built-in Pub/Sub support (with or without Redis), static file support and many other features, optimized for Ruby MRI on Linux / BSD / macOS / Windows

## [ipaddr](https://github.com/ruby/ipaddr)

| | |
|---|---|
| **Version** | 1.2.8 |
| **Authors** | Akinori MUSHA, Hajimu UMEMOTO |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.4 |

A class to manipulate an IP address in ruby

IPAddr provides a set of methods to manipulate an IP address. Both IPv4 and IPv6 are supported.

## [ipaddress](https://github.com/bluemonk/ipaddress)

| | |
|---|---|
| **Version** | 0.8.3 |
| **Authors** | bluemonk, mikemackintosh |
| **License** | MIT |

IPv4/IPv6 address manipulation library

IPAddress is a Ruby library designed to make manipulation of IPv4 and IPv6 addresses both powerful and simple. It mantains a layer of compatibility with Ruby's own IPAddr, while addressing many of its issues.

## [irb](https://github.com/ruby/irb)

| | |
|---|---|
| **Version** | 1.16.0 |
| **Authors** | aycabta, Keiju ISHITSUKA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7 |

Interactive Ruby command-line tool for REPL (Read Eval Print Loop).

**Dependencies:** reline (>= 0.4.2), rdoc (>= 4.0.0), pp (>= 0.6.0)

## [irb-ai](https://github.com/st0012/irb-ai)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Stan Lo |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

IRB commands powered by AI.

IRB-AI is an experimental project that explores various ways to enhance users' IRB experience through AI.

**Dependencies:** irb (~> 1.6), tracer (~> 0.2.2), ruby-openai (~> 4.1), tty-markdown (~> 0.7.2)

## [irb-kit](https://alchemists.io/projects/irb-kit)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

Extends IRB by providing additional productivity enhancements.

**Dependencies:** irb (~> 1.16), zeitwerk (~> 2.7)

## [irb-theme-dracula](https://github.com/katsyoshi/irb-theme-dracula)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | MATSUMOTO, Katsuyoshi |
| **Ruby** | >= 2.6.0 |

irb configuration for color scheme

irb color config

**Dependencies:** irb (>= 0), reline (>= 0.4.0)

## [irbtools](https://github.com/janlelis/irbtools)

| | |
|---|---|
| **Version** | 4.2.0 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 4.0 |

Irbtools happy IRB.

The Irbtools make working with Ruby's IRB console more fun & productive.

**Dependencies:** irb (~> 1.16), every_day_irb (~> 2.3), fancy_irb (~> 2.1, >= 2.1.3), wirb (~> 3.0), hirb (~> 0.7, >= 0.7.3), paint (>= 0.9, < 3.0), clipboard (>= 1.4, < 3.0), interactive_editor (~> 0.0, >= 0.0.12), coderay (~> 1.1), debugging (~> 2.1), looksee (>= 5.0, < 7.0), object_shadow (~> 1.1, >= 1.1.2), code (>= 0.9.5, < 2.0), core_docs (~> 0.9.13), methodfinder (~> 2.2, >= 2.2.5), ruby_version (~> 1.0), ruby_engine (~> 2.0), os (~> 1.1, >= 1.1.4)

## [iruby](https://github.com/SciRuby/iruby)

| | |
|---|---|
| **Version** | 0.8.2 |
| **Authors** | Daniel Mendler, The SciRuby developers |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Ruby Kernel for Jupyter

A Ruby kernel for Jupyter environment. Try it at try.jupyter.org.

**Dependencies:** data_uri (~> 0.1), ffi-rzmq (>= 0), irb (>= 0), logger (>= 0), mime-types (>= 3.3.1), multi_json (~> 1.11)

## [isolator](https://github.com/palkan/isolator)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Detect non-atomic interactions within DB transactions

**Dependencies:** sniffer (>= 0.5.0)

## [ivar](https://github.com/avdi/ivar)

| | |
|---|---|
| **Version** | 0.4.7 |
| **Authors** | Avdi Grimm |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

A Ruby gem that automatically checks for typos in instance variables.

Ivar is a Ruby gem that automatically checks for typos in instance variables.

**Dependencies:** prism (~> 1.2)

## [jaro_winkler](https://github.com/tonytonyjan/jaro_winkler)

| | |
|---|---|
| **Version** | 1.6.1 |
| **Authors** | Jian Weihang |
| **License** | MIT |

An implementation of Jaro-Winkler distance algorithm written \ in C extension which supports any kind of string encoding.

jaro_winkler is an implementation of Jaro-Winkler \ distance algorithm which is written in C extension and will fallback to pure \ Ruby version in platforms other than MRI/KRI like JRuby or Rubinius. Both of \ C and Ruby implementation support any kind of string encoding, such as \ UTF-8, EUC-JP, Big5, etc.

## [jbuilder](https://github.com/rails/jbuilder)

| | |
|---|---|
| **Version** | 2.14.1 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Create JSON structures via a Builder-style DSL

**Dependencies:** activesupport (>= 7.0.0), actionview (>= 7.0.0)

## [jemoji](https://github.com/jekyll/jemoji)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | GitHub, Inc. |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

GitHub-flavored emoji plugin for Jekyll

**Dependencies:** gemoji (~> 3.0), html-pipeline (~> 2.2), jekyll (>= 3.0, < 5.0)

## [jira-ruby](http://www.sumoheavy.com)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | SUMO Heavy Industries, test IO |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Ruby Gem for use with the Atlassian JIRA REST API

API for JIRA

**Dependencies:** activesupport (>= 0), atlassian-jwt (>= 0), multipart-post (>= 0), oauth (~> 1.0)

## [jirasync](https://github.com/programmiersportgruppe/jira-sync)

| | |
|---|---|
| **Version** | 0.4.6 |
| **Authors** | Felix Leipold |

jirasync synchronises jira projects to the local file system

jirasync synchronises tickets from a jira project to the local file system. It supports a complete fetch operation as well as an incremental update.  Each ticket is stored in a simple, pretty printed JSON file.

**Dependencies:** trollop (>= 0), httparty (>= 0), parallel (>= 0), ruby-progressbar (>= 0)

## [jmespath](http://github.com/trevorrowe/jmespath.rb)

| | |
|---|---|
| **Version** | 1.6.2 |
| **Authors** | Trevor Rowe |
| **License** | Apache-2.0 |

JMESPath - Ruby Edition

Implements JMESPath for Ruby

## [job-iteration](https://github.com/shopify/job-iteration)

| | |
|---|---|
| **Version** | 1.12.0 |
| **Authors** | Shopify |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Makes your background jobs interruptible and resumable.

**Dependencies:** activejob (>= 6.1)

## [journey](http://github.com/rails/journey)

| | |
|---|---|
| **Version** | 1.0.4 |
| **Authors** | Aaron Patterson |

Journey is a router

Journey is a router.  It routes requests.

## [jquery-rails](https://github.com/rails/jquery-rails)

| | |
|---|---|
| **Version** | 4.6.1 |
| **Authors** | André Arko |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Use jQuery with Rails 4+

This gem provides jQuery and the jQuery-ujs driver for your Rails 4+ application.

**Dependencies:** railties (>= 4.2.0), thor (>= 0.14, < 2.0), rails-dom-testing (>= 1, < 3)

## [jquery-ui-rails](https://github.com/jquery-ui-rails/jquery-ui-rails)

| | |
|---|---|
| **Version** | 8.0.0 |
| **Authors** | Jo Liss |
| **License** | MIT |

jQuery UI packaged for the Rails asset pipeline

jQuery UI's JavaScript, CSS, and image files packaged for the Rails 3.1+ asset pipeline

**Dependencies:** railties (>= 3.2.16)

## [js_regex](https://github.com/jaynetics/js_regex)

| | |
|---|---|
| **Version** | 3.14.0 |
| **Authors** | Janosch Müller |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

Converts Ruby regexes to JavaScript regexes.

JsRegex converts Ruby's native regular expressions for JavaScript, taking care of various incompatibilities and returning warnings for unsolvable differences.

**Dependencies:** character_set (~> 1.4), regexp_parser (~> 2.11), regexp_property_values (~> 1.0)

## [json](https://github.com/ruby/json)

| | |
|---|---|
| **Version** | 2.18.0 |
| **Authors** | Florian Frank |
| **License** | Ruby |
| **Ruby** | >= 2.7 |

JSON Implementation for Ruby

This is a JSON implementation as a Ruby extension in C.

## [json-canonicalization](http://github.com/dryruby/json-canonicalization)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Gregg Kellogg |
| **License** | Unlicense |
| **Ruby** | >= 3.0 |

JSON Canonicalization for Ruby.

JSON::Canonicalization generates canonical JSON output from Ruby objects.

## [json-jwt](https://github.com/nov/json-jwt)

| | |
|---|---|
| **Version** | 1.17.0 |
| **Authors** | nov matake |
| **License** | MIT |
| **Ruby** | >= 2.4 |

JSON Web Token and its family (JSON Web Signature, JSON Web Encryption and JSON Web Key) in Ruby

**Dependencies:** activesupport (>= 4.2), base64 (>= 0), bindata (>= 0), aes_key_wrap (>= 0), faraday (~> 2.0), faraday-follow_redirects (>= 0)

## [json-repair](https://github.com/sashazykov/json-repair-rb)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Aleksandr Zykov |
| **License** | ISC |
| **Ruby** | >= 3.0.0 |

Repairs broken JSON strings.

This is a simple gem that repairs broken JSON strings.

## [json-schema](https://github.com/voxpupuli/json-schema/)

| | |
|---|---|
| **Version** | 4.3.1 |
| **Authors** | Kenny Hoxworth, Vox Pupuli |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Ruby JSON Schema Validator

**Dependencies:** addressable (>= 2.8)

## [json_mend](https://github.com/le0pard/json_mend)

| | |
|---|---|
| **Version** | 0.1.7 |
| **Authors** | Oleksii Vasyliev |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Repair broken JSON

JsonMend is a robust Ruby gem designed to repair broken or malformed JSON strings. It is specifically optimized to handle common errors found in JSON generated by Large Language Models (LLMs), such as missing quotes, trailing commas, unescaped characters, and stray comments

**Dependencies:** json (>= 2.3), strscan (>= 3)

## [json_rpc_handler](https://github.com/Shopify/json-rpc-handler)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Ates Goral |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A spec-compliant JSON-RPC 2.0 handler

## [json_schema](https://github.com/brandur/json_schema)

| | |
|---|---|
| **Version** | 0.20.9 |
| **Authors** | Brandur |
| **License** | MIT |

A JSON Schema V4 and Hyperschema V4 parser and validator.

## [json_schemer](https://github.com/davishmcclurg/json_schemer)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | David Harsha |
| **License** | MIT |
| **Ruby** | >= 2.7 |

JSON Schema validator. Supports drafts 4, 6, 7, 2019-09, 2020-12, OpenAPI 3.0, and OpenAPI 3.1.

**Dependencies:** bigdecimal (>= 0), hana (~> 1.3), regexp_parser (~> 2.0), simpleidn (~> 0.2)

## [json_skooma](https://github.com/skryukov/json_skooma)

| | |
|---|---|
| **Version** | 0.2.5 |
| **Authors** | Svyatoslav Kryukov |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

I bring some sugar for your JSONs.

**Dependencies:** bigdecimal (>= 0), zeitwerk (~> 2.6), hana (~> 1.3), regexp_parser (~> 2.0), uri-idna (~> 0.2)

## [jsonapi-renderer](https://github.com/jsonapi-rb/jsonapi-renderer)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Lucas Hosseini |
| **License** | MIT |

Render JSONAPI documents.

Efficiently render JSON API documents.

## [jsonapi-serializable](https://github.com/jsonapi-rb/jsonapi-serializable)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Lucas Hosseini |
| **License** | MIT |

Conveniently serialize JSON API resources.

Powerful DSL for building resource classes - efficient and flexible rendering.

**Dependencies:** jsonapi-renderer (~> 0.2.0)

## [jsonrpc-rails](https://github.com/seuros/jsonrpc-rails)

| | |
|---|---|
| **Version** | 0.5.4 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |

A Railtie-based gem that brings JSON-RPC 2.0 support to your Rails application.

Integrates into Rails, allowing you to render JSON-RPC responses and validate incoming requests according to the JSON-RPC 2.0 specification. Includes middleware for strict request validation and a custom renderer. Designed for Rails 8+.

**Dependencies:** railties (>= 8.0.1)

## [jumon](https://github.com/moekidev/jumon)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Moeki Kawakami |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

The Prompt testing library for LLM that allows comparing patterns of prompts.

**Dependencies:** ruby-openai (~> 4.1), cli-ui (~> 2.2)

## [justprep](http://github.com/MadBomber/justprep)

| | |
|---|---|
| **Version** | 1.2.5 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Just a pre-processor for CLI task runners like 'just'

justprep is a CLI tool implemented as a Ruby gem AND a compiled Crystal binary.  It allows a task file to be auto-generated from seperate source files that contain inclusionary keywords such as include, import, require and with.

## [jwt](https://github.com/jwt/ruby-jwt)

| | |
|---|---|
| **Version** | 2.10.2 |
| **Authors** | Tim Rudat |
| **License** | MIT |
| **Ruby** | >= 2.5 |

JSON Web Token implementation in Ruby

A pure ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.

**Dependencies:** base64 (>= 0)

## [jwt_sessions](http://rubygems.org/gems/jwt_sessions)

| | |
|---|---|
| **Version** | 3.2.4 |
| **Authors** | Julija Alieckaja |
| **License** | MIT |

JWT Sessions

XSS/CSRF safe JWT auth designed for SPA

**Dependencies:** jwt (>= 2.9, < 3)

## [kamal](https://github.com/basecamp/kamal)

| | |
|---|---|
| **Version** | 2.10.1 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |

Deploy web apps in containers to servers running Docker with zero downtime.

**Dependencies:** activesupport (>= 7.0), sshkit (>= 1.23.0, < 2.0), net-ssh (~> 7.3), thor (~> 1.3), dotenv (~> 3.1), zeitwerk (>= 2.6.18, < 3.0), ed25519 (~> 1.4), bcrypt_pbkdf (~> 1.0), concurrent-ruby (~> 1.2), base64 (~> 0.2)

## [kaminari](https://github.com/kaminari/kaminari)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | Akira Matsuda, Yuki Nishijima, Zachary Scott, Hiroshi Shibata |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A pagination engine plugin for Rails 4+ and other modern frameworks

Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 4+

**Dependencies:** activesupport (>= 4.1.0), kaminari-core (= 1.2.2), kaminari-actionview (= 1.2.2), kaminari-activerecord (= 1.2.2)

## [kaminari-actionview](https://github.com/kaminari/kaminari)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | Akira Matsuda |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Kaminari Action View adapter

kaminari-actionview provides pagination helpers for your Action View templates

**Dependencies:** kaminari-core (= 1.2.2), actionview (>= 0)

## [kaminari-activerecord](https://github.com/kaminari/kaminari)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | Akira Matsuda |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Kaminari Active Record adapter

kaminari-activerecord lets your Active Record models be paginatable

**Dependencies:** kaminari-core (= 1.2.2), activerecord (>= 0)

## [kaminari-core](https://github.com/kaminari/kaminari)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | Akira Matsuda |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Kaminari's core pagination library

kaminari-core includes pagination logic independent from ORMs and view libraries

## [karafka-core](https://karafka.io)

| | |
|---|---|
| **Version** | 2.5.8 |
| **Authors** | Maciej Mensfeld |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Karafka ecosystem core modules

A toolset of small support modules used throughout the Karafka ecosystem

**Dependencies:** karafka-rdkafka (>= 0.20.0), logger (>= 1.6.0)

## [karafka-rdkafka](https://rubygems.org/gems/karafka-rdkafka)

| | |
|---|---|
| **Version** | 0.23.1 |
| **Authors** | Thijs Cadier, Maciej Mensfeld |
| **License** | MIT |
| **Ruby** | >= 3.2 |

The rdkafka gem is a modern Kafka client library for Ruby based on librdkafka. It wraps the production-ready C client using the ffi gem and targets Kafka 1.0+ and Ruby 2.7+.

Modern Kafka client library for Ruby based on librdkafka

**Dependencies:** ffi (~> 1.17.1), json (> 2.0), logger (>= 0), mini_portile2 (~> 2.6), rake (> 12)

## [kbs](https://github.com/madbomber/kbs)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Knowledge-Based System with RETE inference, Blackboard architecture, and AI integration

A comprehensive Ruby implementation of a Knowledge-Based System featuring:  • RETE Algorithm: Optimized forward-chaining inference engine with unlinking optimization for high-performance pattern matching • Declarative DSL: Readable, expressive syntax for rule definition with built-in condition helpers • Blackboard Architecture: Multi-agent coordination with message passing and knowledge source registration • Flexible Persistence: SQLite (durable), Redis (fast), and hybrid storage backends with audit trails • Concurrent Execution: Thread-safe auto-inference mode for real-time processing • AI Integration: Native support for LLM integration (Ollama, OpenAI) for hybrid symbolic/neural reasoning • Production Features: Session management, fact history, query API, statistics tracking  Perfect for expert systems, trading algorithms, IoT monitoring, portfolio management, and AI-enhanced decision systems.

**Dependencies:** sqlite3 (~> 1.6)

## [keynote](https://github.com/evilmartians/keynote)

| | |
|---|---|
| **Version** | 2.0.3 |
| **Authors** | Ryan Fitzgerald, Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Flexible presenters for Rails

A presenter is an object that encapsulates view logic. Like Rails helpers, presenters help you keep complex logic out of your templates. Keynote provides a consistent interface for defining and instantiating presenters.

**Dependencies:** actionview (>= 7.0.0), ruby-next (~> 1.0)

## [kimurai](https://github.com/vifreefly/kimuraframework)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Victor Afanasev |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Modern web scraping framework written in Ruby and based on Capybara/Nokogiri

**Dependencies:** activesupport (>= 0), cliver (>= 0), csv (>= 0), murmurhash3 (>= 0), nokogiri (>= 0), ostruct (>= 0), thor (>= 0), mutex_m (>= 0), nkf (>= 0), reline (>= 0), capybara (~> 3.40), capybara-mechanize (~> 1.13), selenium-webdriver (~> 4.27), headless (>= 0), pmap (>= 0), whenever (>= 0), pry (>= 0), rbcat (~> 1.0), nukitori (>= 0)

## [kmeans-clusterer](https://github.com/gbuesing/kmeans-clusterer)

| | |
|---|---|
| **Version** | 0.11.4 |
| **Authors** | Geoff Buesing |
| **License** | MIT |

k-means clustering

k-means clustering. Uses NArray for fast calculations.

**Dependencies:** narray (~> 0.6)

## [kramdown](http://kramdown.gettalong.org)

| | |
|---|---|
| **Version** | 2.3.1 |
| **Authors** | Thomas Leitner |
| **License** | MIT |
| **Ruby** | >= 2.3 |

kramdown is a fast, pure-Ruby Markdown-superset converter.

kramdown is yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition and supporting several common extensions.

**Dependencies:** rexml (>= 0)

## [kramdown-man](https://github.com/postmodern/kramdown-man#readme)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Postmodern |
| **License** | MIT |

Allows you to write man pages in pure markdown.

Allows you to write man pages for commands in pure Markdown and convert them to roff using Kramdown.

**Dependencies:** kramdown (~> 2.0)

## [kramdown-parser-gfm](https://github.com/kramdown/parser-gfm)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Thomas Leitner |
| **License** | MIT |
| **Ruby** | >= 2.3 |

kramdown-parser-gfm provides a kramdown parser for the GFM dialect of Markdown

**Dependencies:** kramdown (~> 2.0)

## [kredis](https://github.com/rails/kredis)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Kasper Timm Hansen, David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Higher-level data structures built on Redis.

**Dependencies:** activesupport (>= 6.0.0), activemodel (>= 6.0.0), redis (>= 4.2, < 6)

## [kwalify](http://www.kuwata-lab.com/kwalify/)

| | |
|---|---|
| **Version** | 0.7.2 |
| **Authors** | makoto kuwata |

a parser, schema validator, and data-binding tool for YAML and JSON.

Kwalify is a parser, schema validator, and data binding tool for YAML and JSON.

## [lambdakiq](https://github.com/rails-lambda/lambdakiq)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Ken Collins |
| **License** | MIT |

Scalable Rails Background Processing with AWS Lambda & SQS.

**Dependencies:** activejob (>= 0), aws-sdk-sqs (>= 0), concurrent-ruby (>= 0), railties (>= 0)

## [lanet](https://github.com/davidesantangelo/lanet)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Davide Santangelo |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Powerful CLI/API tool for local network communication and discovery

Lanet provides a simple yet powerful API for LAN device discovery, secure messaging, and real-time network monitoring. Features include encrypted communications, network scanning, targeted and broadcast messaging, host pinging, secure file transfers, mesh networking, and advanced traceroute capabilities. Version 1.0.0 brings significant architectural improvements with better resource management, enhanced error handling, and improved code quality while maintaining 100% backward compatibility.

**Dependencies:** thor (~> 1.2)

## [langchainrb](https://rubygems.org/gems/langchainrb)

| | |
|---|---|
| **Version** | 0.16.1 |
| **Authors** | Andrei Bondarev |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Build LLM-backed Ruby applications with Ruby's Langchain.rb

**Dependencies:** baran (~> 0.1.9), json-schema (~> 4), zeitwerk (~> 2.5), pragmatic_segmenter (~> 0.3.0), matrix (>= 0)

## [langchainrb_rails](https://rubygems.org/gems/langchainrb_rails)

| | |
|---|---|
| **Version** | 0.1.12 |
| **Authors** | Andrei Bondarev |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Rails wrapper for langchainrb gem

**Dependencies:** langchainrb (>= 0.7, < 0.17)

## [language_list](https://github.com/scsmith/language_list)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Steve Smith |

A list of languages and methods to find and work with these languages.

A list of languages based upon ISO-639-1 and ISO-639-3 with functions to retrieve only common languages.

## [language_server-protocol](https://github.com/mtsmfm/language_server-protocol-ruby)

| | |
|---|---|
| **Version** | 3.17.0.5 |
| **Authors** | Fumiaki MATSUSHIMA |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A Language Server Protocol SDK

## [lapsoss](https://github.com/seuros/lapsoss)

| | |
|---|---|
| **Version** | 0.4.11 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Modern error reporting with pluggable adapters for Rails applications

Lapsoss provides a clean, adapter-based approach to error reporting that doesn't monkey patch your application. Send errors to any error tracking service or custom backend through a unified API.

**Dependencies:** activesupport (>= 7.2, < 9.0), concurrent-ruby (>= 1.3.1), faraday (~> 2.0), faraday-retry (~> 2.0), zeitwerk (~> 2.6), async-http-faraday (~> 0.19, >= 0.19.0)

## [launchy](https://github.com/copiousfreetime/launchy)

| | |
|---|---|
| **Version** | 2.5.2 |
| **Authors** | Jeremy Hinegardner |
| **License** | ISC |
| **Ruby** | >= 2.3.0 |

Launchy is helper class for launching cross-platform applications in a fire and forget manner.

Launchy is helper class for launching cross-platform applications in a fire and forget manner. There are application concepts (browser, email client, etc) that are common across all platforms, and they may be launched differently on each platform. Launchy is here to make a common approach to launching external applications from within ruby programs.

**Dependencies:** addressable (~> 2.8)

## [lbfgsb](https://github.com/yoshoku/lbfgsb.rb)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Lbfgsb.rb is a Ruby binding for L-BFGS-B.

Lbfgsb.rb is a Ruby binding for L-BFGS-B that is a limited-memory algorithm for solving large nonlinear optimization problems subject to simple bounds on the variables.

**Dependencies:** numo-narray (>= 0.9.1)

## [ld-eventsource](https://github.com/launchdarkly/ruby-eventsource)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | LaunchDarkly |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

LaunchDarkly SSE client

LaunchDarkly SSE client for Ruby

**Dependencies:** concurrent-ruby (~> 1.0), http (>= 4.4.1, < 6.0.0)

## [lefthook](https://github.com/evilmartians/lefthook)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | A.A.Abroskin, Evil Martians |
| **License** | MIT |

A single dependency-free binary to manage all your git hooks that works with any language in any environment, and in all common team workflows.

## [letter_opener](https://github.com/ryanb/letter_opener)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | Ryan Bates |
| **License** | MIT |

Preview mail in browser instead of sending.

When mail is sent from your application, Letter Opener will open a preview in the browser instead of sending.

**Dependencies:** launchy (>= 2.2, < 4)

## [letter_opener_web](https://github.com/fgrehm/letter_opener_web)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Fabio Rehm, David Muto |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Gives letter_opener an interface for browsing sent emails

**Dependencies:** actionmailer (>= 6.1), letter_opener (~> 1.9), railties (>= 6.1), rexml (>= 0)

## [leva](https://github.com/kieranklaassen/leva)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Kieran Klaassen |
| **License** | MIT |

Flexible Evaluation Framework for Language Models in Rails

Leva is a Ruby on Rails framework for evaluating Language Models (LLMs) using ActiveRecord datasets. It provides a flexible structure for creating experiments, managing datasets, and implementing various evaluation logic.

**Dependencies:** rails (>= 7.2.0), liquid (~> 5.5)

## [libgd-gis](https://github.com/ggerman/libgd-gis)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Germán Alberto Giménez Silva |
| **License** | MIT |
| **Ruby** | >= 3.3 |

Geospatial raster rendering for Ruby using libgd

A native GIS raster engine for Ruby built on libgd. Render maps, GeoJSON, heatmaps and tiles.

**Dependencies:** ruby-libgd (~> 0.2.3, >= 0.2.3)

## [libyajl2](https://github.com/chef/libyajl2-gem)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | lamont-granquist |
| **License** | Apache-2.0 |

Installs a vendored copy of libyajl2 for distributions which lack it

## [license-acceptance](https://github.com/chef/license-acceptance/)

| | |
|---|---|
| **Version** | 2.1.13 |
| **Authors** | tyler-ball |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.4 |

Chef End User License Agreement Acceptance

Chef End User License Agreement Acceptance for Ruby products

**Dependencies:** pastel (~> 0.7), tomlrb (>= 1.2, < 3.0), tty-box (~> 0.6), tty-prompt (~> 0.20)

## [licensed](https://github.com/github/licensed)

| | |
|---|---|
| **Version** | 5.0.4 |
| **Authors** | GitHub |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Extract and validate the licenses of dependencies.

Licensed automates extracting and validating the licenses of dependencies.

**Dependencies:** csv (~> 3.3), licensee (~> 9.16), thor (~> 1.2), pathname-common_prefix (~> 0.0.1), tomlrb (~> 2.0), ruby-xxHash (~> 0.4.0), parallel (~> 1.22), reverse_markdown (>= 2.1, < 4.0), json (~> 2.6)

## [licensee](https://github.com/benbalter/licensee)

| | |
|---|---|
| **Version** | 9.18.0 |
| **Authors** | Ben Balter |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A Ruby Gem to detect open source project licenses

Licensee automates the process of reading LICENSE files and compares their contents to known licenses using a fancy maths.

**Dependencies:** dotenv (>= 2, < 4), octokit (>= 4.20, < 10.0), reverse_markdown (>= 1, < 4), rugged (>= 0.24, < 2.0), thor (>= 0.19, < 2.0)

## [light_services](https://github.com/nicolaslima/light_services)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Nicolas Lima |
| **License** | MIT |

A simple base to help build Services

**Dependencies:** activemodel (>= 4.2.6)

## [lightgbm](https://github.com/ankane/lightgbm-ruby)

| | |
|---|---|
| **Version** | 0.4.3 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.1 |

High performance gradient boosting for Ruby

**Dependencies:** ffi (>= 0)

## [linefit](http://rubygems.org/gems/linefit)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Eric Cline, Richard Anderson |

LineFit is a linear regression math class.

LineFit does weighted or unweighted least-squares line fitting to two-dimensional data (y = a + b * x). (Linear Regression)

## [lint_roller](https://github.com/standardrb/lint_roller)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Justin Searls |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A plugin specification for linter and formatter rulesets

## [lipgloss](https://github.com/marcoroth/lipgloss-ruby)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2, < 4.1.dev |

Ruby wrapper for Charm's lipgloss. CSS-like terminal styling library.

Style Definitions for Nice Terminal Layouts. Built with TUIs in mind.

## [lipsum](http://github.com/glejeune/lipsum)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Gregoire Lejeune |

Get placeholder text from lipsum.com

This class allow you to retrive "lorem ipsum" placeholder text from lipsum.com.

**Dependencies:** nokogiri (>= 0)

## [liquid](http://www.liquidmarkup.org)

| | |
|---|---|
| **Version** | 4.0.3 |
| **Authors** | Tobias Lütke |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

A secure, non-evaling end user template engine with aesthetic markup.

## [listen](https://github.com/guard/listen)

| | |
|---|---|
| **Version** | 3.10.0 |
| **Authors** | Thibaud Guillaume-Gentil |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Listen to file modifications

The Listen gem listens to file modifications and notifies you about the changes. Works everywhere!

**Dependencies:** logger (>= 0), rb-fsevent (~> 0.10, >= 0.10.3), rb-inotify (~> 0.9, >= 0.9.10)

## [lite-memoize](http://drexed.github.io/lite-memoize)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Juan Gomez |
| **License** | MIT |

Cache and memoization helpers for ruby Ruby classes

## [lite-statistics](http://drexed.github.io/lite-statistics)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Juan Gomez |
| **License** | MIT |

Generate statistics from collections of data points

**Dependencies:** lite-memoize (>= 0)

## [literal](https://literal.fun)

| | |
|---|---|
| **Version** | 1.8.1 |
| **Authors** | Joel Drapper |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Enums, properties, generics, structured objects and runtime type checking.

**Dependencies:** zeitwerk (>= 0)

## [little-plugger](http://gemcutter.org/gems/little-plugger)

| | |
|---|---|
| **Version** | 1.1.4 |
| **Authors** | Tim Pease |

LittlePlugger is a module that provides Gem based plugin management.

LittlePlugger is a module that provides Gem based plugin management. By extending your own class or module with LittlePlugger you can easily manage the loading and initializing of plugins provided by other gems.

## [live](https://github.com/socketry/live)

| | |
|---|---|
| **Version** | 0.18.0 |
| **Authors** | Samuel Williams, Olle Jonsson, Tatsuhiro Ujihisa |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Live HTML tags updated via a WebSocket.

**Dependencies:** async-websocket (~> 0.27), protocol-websocket (~> 0.19), xrb (~> 0.10)

## [llama-rb](https://github.com/zfletch/llama-rb)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | zfletch |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby interface for Llama

ggerganov/llama.cpp with Ruby hooks

## [llhttp-ffi](https://github.com/bryanp/llhttp/)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Bryan Powell |
| **License** | MPL-2.0 |
| **Ruby** | >= 2.5.0 |

Ruby FFI bindings for llhttp.

**Dependencies:** ffi-compiler (~> 1.0), rake (~> 13.0)

## [llm-docs-builder](https://github.com/mensfeld/llm-docs-builder)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | Maciej Mensfeld |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Build and optimize documentation for LLMs - generate llms.txt, transform markdown, and more

A comprehensive Ruby tool for building and optimizing documentation for Large Language Models. Features include: generating llms.txt files from documentation directories with automatic file prioritization, transforming individual markdown files by expanding relative links to absolute URLs, bulk transforming entire documentation trees with customizable exclusion patterns, comparing content sizes to measure context window savings, and serving LLM-optimized documentation. Provides both CLI and Ruby API with configuration file support.

**Dependencies:** nokogiri (~> 1.17), zeitwerk (~> 2.6)

## [llm-shell](https://github.com/llmrb/llm-shell)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Antar Azri, 0x1eef |
| **License** | 0BSD |
| **Ruby** | >= 3.2 |

llm-shell is an extensible, developer-oriented command-line console that can interact with multiple Large Language Models (LLMs).

**Dependencies:** redcarpet (~> 3.6)

## [llm.rb](https://github.com/llmrb/llm)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Antar Azri, 0x1eef |
| **License** | 0BSD |
| **Ruby** | >= 3.2.0 |

llm.rb is a zero-dependency Ruby toolkit for Large Language Models that includes OpenAI, Gemini, Anthropic, xAI (grok), zAI, DeepSeek, Ollama, and LlamaCpp. The toolkit includes full support for chat, streaming, tool calling, audio, images, files, and structured outputs.

## [llm_classifier](https://github.com/AxiumFoundry/llm_classifier)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Dmitry Sychev |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

LLM-powered classification for Ruby with pluggable adapters and Rails integration

A flexible Ruby gem for building LLM-based classifiers. Define categories, system prompts, and domain knowledge using a clean DSL. Supports multiple LLM backends (ruby_llm, OpenAI, Anthropic) and integrates seamlessly with Rails.

**Dependencies:** zeitwerk (~> 2.6)

## [llm_orchestrator](https://github.com/aquaflamingo/llm_orchestrator)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | @aquaflamingo |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A lightweight ruby framework for orchestrating operations via LLM APIs

A simple and flexible framework for managing prompts and LLM interactions with OpenAI and Anthropic Claude

**Dependencies:** anthropic (~> 0.3.2), ruby-openai (~> 6.0)

## [llm_rescuer](https://github.com/barodeur/llm_rescuer)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Paul Chobert |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Fix the billion-dollar mistake by spending billions on LLM tokens! 🤖💰

LLM Rescuer uses artificial intelligence to guess what you probably meant when you called a method on nil. Instead of crashing with NoMethodError, it asks GPT to analyze your code and hallucinate a reasonable response. Because clearly, the best way to solve Tony Hoare's billion-dollar mistake is to throw AI at it until it works. What could possibly go wrong? 🎭

**Dependencies:** binding_of_caller (~> 1.0.1), ruby_llm (~> 1.8.2), ruby_llm-schema (~> 0.2.1)

## [localhost](https://github.com/socketry/localhost)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Samuel Williams, Olle Jonsson, Ye Lin Aung, Akshay Birajdar, Antonio Terceiro, Aurel Branzeanu, Colin Shea, Gabriel Sobrinho, Juri Hahn, Richard S. Leung, Yuuji Yaginuma |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Manage a local certificate authority for self-signed localhost development servers.

## [lockfile](https://github.com/ahoward/lockfile)

| | |
|---|---|
| **Version** | 2.1.3 |
| **Authors** | Ara T. Howard |
| **License** | Ruby |

lockfile

a ruby library for creating perfect and NFS safe lockfiles

## [lode](https://alchemists.io/projects/lode)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A monadic store of marshaled objects.

**Dependencies:** dry-monads (~> 1.9), pstore (~> 0.2), refinements (~> 14.0), zeitwerk (~> 2.7)

## [log_analyzer](https://github.com/igorkasyanchuk)

| | |
|---|---|
| **Version** | 0.3.3 |
| **Authors** | Igor Kasyanchuk |
| **License** | MIT |

log_analyzer gem is created to get statistics about your views rendering performance.

**Dependencies:** thor (>= 0), rake (>= 0), terminal-table (>= 0), colorize (>= 0), prawn (>= 0), prawn-table (>= 0), spreadsheet (>= 0)

## [logger](https://github.com/ruby/logger)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Naotoshi Seo, SHIBATA Hiroshi |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Provides a simple logging utility for outputting messages.

## [logging](http://rubygems.org/gems/logging)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Tim Pease |
| **License** | MIT |

A flexible and extendable logging library for Ruby

**Logging** is a flexible logging library for use in Ruby programs based on the design of Java's log4j library. It features a hierarchical logging system, custom level names, multiple output destinations per log event, custom formatting, and more.

**Dependencies:** little-plugger (~> 1.1), multi_json (~> 1.14)

## [lograge](https://github.com/roidrage/lograge)

| | |
|---|---|
| **Version** | 0.14.0 |
| **Authors** | Mathias Meyer, Ben Lovell, Michael Bianco |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Tame Rails' multi-line logging into a single line per request

**Dependencies:** actionpack (>= 4), activesupport (>= 4), railties (>= 4), request_store (~> 1.0)

## [logutils](https://github.com/rubylibs/logutils)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 1.9.2 |

Another Logger

## [loofah](https://github.com/flavorjones/loofah)

| | |
|---|---|
| **Version** | 2.25.0 |
| **Authors** | Mike Dalessio, Bryan Helmkamp |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Loofah is a general library for manipulating and transforming HTML/XML documents and fragments, built on top of Nokogiri.

Loofah is a general library for manipulating and transforming HTML/XML documents and fragments, built on top of Nokogiri.  Loofah also includes some HTML sanitizers based on `html5lib`'s safelist, which are a specific application of the general transformation functionality.

**Dependencies:** crass (~> 1.0.2), nokogiri (>= 1.12.0)

## [lookbook](https://github.com/lookbook-hq/lookbook)

| | |
|---|---|
| **Version** | 2.3.14 |
| **Authors** | Mark Perkins |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Lookbook is a UI development environment for Ruby on Rails applications

**Dependencies:** css_parser (>= 0), activemodel (>= 0), zeitwerk (~> 2.5), railties (>= 5.0), view_component (>= 2.0), redcarpet (~> 3.5), rouge (>= 3.26, < 5.0), yard (~> 0.9), htmlbeautifier (~> 1.3), htmlentities (~> 4.3.4), marcel (~> 1.0)

## [looksee](http://github.com/oggy/looksee)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | George Ogata |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Supercharged method introspection in IRB.

## [lp](https://github.com/dannyben/lp)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Lovely print

## [lrama](https://github.com/ruby/lrama)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | Yuichiro Kaneko |
| **License** | GPL-3.0-or-later |
| **Ruby** | >= 2.5.0 |

LALR (1) parser generator written by Ruby

## [lru_redux](https://github.com/SamSaffron/lru_redux)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Sam Saffron, Kaijah Hougham |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

An efficient implementation of an lru cache

## [lumberjack](https://github.com/bdurand/lumberjack)

| | |
|---|---|
| **Version** | 1.4.2 |
| **Authors** | Brian Durand |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A simple, powerful, and fast logging utility with excellent structured logging support that can be a drop in replacement for the standard library Logger.

## [macos](https://github.com/ksylvest/macos)

| | |
|---|---|
| **Version** | 0.1.8 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

An interface with macOS.

An interface (designed for LLMs) to macOS.

**Dependencies:** ffi (>= 0), fiddle (>= 0), zeitwerk (>= 0)

## [madmin](https://github.com/excid3/madmin)

| | |
|---|---|
| **Version** | 2.3.2 |
| **Authors** | Chris Oliver, Andrea Fomera |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A modern admin for Ruby on Rails apps

It's an admin, obviously.

**Dependencies:** rails (>= 7.0.0), pagy (>= 3.5), propshaft (>= 0), importmap-rails (>= 0), stimulus-rails (>= 0), turbo-rails (>= 0)

## [mail](https://github.com/mikel/mail)

| | |
|---|---|
| **Version** | 2.9.0 |
| **Authors** | Mikel Lindsaar |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Mail provides a nice Ruby DSL for making, sending and reading emails.

A really Ruby Mail handler.

**Dependencies:** logger (>= 0), mini_mime (>= 0.1.1), net-smtp (>= 0), net-imap (>= 0), net-pop (>= 0)

## [main](https://github.com/ahoward/main)

| | |
|---|---|
| **Version** | 6.4.0 |
| **Authors** | Ara T. Howard |
| **License** | Ruby |
| **Ruby** | >= 2.0 |

main

a class factory and dsl for generating command line programs real quick

**Dependencies:** chronic (~> 0.10, >= 0.10.2), fattr (~> 2.4, >= 2.4.0), arrayfields (~> 4.9, >= 4.9.2), map (~> 6.6, >= 6.6.0)

## [maintenance_tasks](https://github.com/Shopify/maintenance_tasks)

| | |
|---|---|
| **Version** | 2.13.0 |
| **Authors** | Shopify Engineering |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A Rails engine for queuing and managing maintenance tasks

**Dependencies:** actionpack (>= 7.1), activejob (>= 7.1), activerecord (>= 7.1), csv (>= 0), job-iteration (>= 1.3.6), railties (>= 7.1), zeitwerk (>= 2.6.2)

## [map](https://github.com/ahoward/map)

| | |
|---|---|
| **Version** | 6.6.0 |
| **Authors** | Ara T. Howard |
| **License** | same as ruby's |

map

the awesome ruby container you've always wanted: a string/symbol indifferent ordered hash that works in all rubies

## [mapping](https://github.com/ioquatix/mapping)

| | |
|---|---|
| **Version** | 1.1.3 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Map an input model to an output model using a mapping model.

## [marameters](https://alchemists.io/projects/marameters)

| | |
|---|---|
| **Version** | 4.6.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A dynamic method parameter enhancer.

**Dependencies:** refinements (~> 13.6), zeitwerk (~> 2.7)

## [marcel](https://github.com/rails/marcel)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Tom Ward |
| **License** | MIT, Apache-2.0 |
| **Ruby** | >= 2.3 |

Simple mime type detection using magic numbers, filenames, and extensions

## [maritaca-ai](https://github.com/gbaptista/maritaca-ai)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | gbaptista |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Interact with Maritaca AI.

A Ruby gem for interacting with Maritaca AI's large language models.

**Dependencies:** event_stream_parser (~> 1.0), faraday (~> 2.9), faraday-typhoeus (~> 1.1)

## [marksmith](https://github.com/avo-hq/marksmith)

| | |
|---|---|
| **Version** | 0.4.8 |
| **Authors** | Adrian Marin |
| **License** | MIT |

Marksmith is a GitHub-style markdown editor for Ruby on Rails applications.

**Dependencies:** activesupport (>= 0)

## [matrix](https://github.com/ruby/matrix)

| | |
|---|---|
| **Version** | 0.4.3 |
| **Authors** | Marc-Andre Lafortune |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

An implementation of Matrix and Vector classes.

## [maxitest](https://github.com/grosser/maxitest)

| | |
|---|---|
| **Version** | 7.1.1 |
| **Authors** | Michael Grosser |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Minitest + all the features you always wanted

**Dependencies:** minitest (>= 6.0.0, < 6.1.0)

## [mcp](https://github.com/modelcontextprotocol/ruby-sdk)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Model Context Protocol |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

The official Ruby SDK for Model Context Protocol servers and clients

**Dependencies:** json_rpc_handler (~> 0.1), json-schema (>= 4.1)

## [mcp-rb](https://github.com/funwarioisii/mcp-rb)

| | |
|---|---|
| **Version** | 0.3.3 |
| **Authors** | funwarioisii |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

A lightweight Ruby framework for implementing MCP (Model Context Protocol) servers

MCP-RB is a Ruby framework that provides a Sinatra-like DSL for implementing Model Context Protocol servers.

## [mdl](https://github.com/markdownlint/markdownlint)

| | |
|---|---|
| **Version** | 0.15.0 |
| **Authors** | Mark Harrison |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Markdown lint tool

Style checker/lint tool for markdown files

**Dependencies:** kramdown (~> 2.3), kramdown-parser-gfm (~> 1.1), mixlib-cli (>= 0), mixlib-config (>= 0), mixlib-shellout (>= 0)

## [mechanize](https://github.com/sparklemotion/mechanize)

| | |
|---|---|
| **Version** | 2.8.5 |
| **Authors** | Eric Hodel, Aaron Patterson, Mike Dalessio, Akinori MUSHA, Lee Jarvis |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

The Mechanize library is used for automating interaction with websites

The Mechanize library is used for automating interaction with websites. Mechanize automatically stores and sends cookies, follows redirects, and can follow links and submit forms.  Form fields can be populated and submitted.  Mechanize also keeps track of the sites that you have visited as a history.

**Dependencies:** addressable (~> 2.8), domain_name (>= 0.5.20190701, ~> 0.5), http-cookie (>= 1.0.3, ~> 1.0), mime-types (~> 3.0), net-http-digest_auth (>= 1.4.1, ~> 1.4), net-http-persistent (>= 2.5.2, < 5.0.dev), nokogiri (>= 1.11.2, ~> 1.11), rubyntlm (>= 0.6.3, ~> 0.6), webrick (~> 1.7), webrobots (~> 0.1.2)

## [memery](https://github.com/tycooon/memery)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Yuri Smirnov |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A gem for memoization.

Memery is a gem for memoization.

## [memo_wise](https://github.com/panorama-ed/memo_wise)

| | |
|---|---|
| **Version** | 1.13.0 |
| **Authors** | Panorama Education, Jacob Evelyn, Jemma Issroff, Marc Siegel |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

The wise choice for Ruby memoization

## [memoist](https://github.com/matthewrudy/memoist)

| | |
|---|---|
| **Version** | 0.16.2 |
| **Authors** | Joshua Peek, Tarmo Tänav, Jeremy Kemper, Eugene Pimenov, Xavier Noria, Niels Ganser, Carl Lerche & Yehuda Katz, jeem, Jay Pignata, Damien Mathieu, José Valim, Matthew Rudy Jacobs |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

memoize methods invocation

## [memoist3](https://github.com/honzasterba/memoist)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Joshua Peek, Tarmo Tänav, Jeremy Kemper, Eugene Pimenov, Xavier Noria, Niels Ganser, Carl Lerche & Yehuda Katz, jeem, Jay Pignata, Damien Mathieu, José Valim, Matthew Rudy Jacobs, Jan Sterba |
| **License** | MIT |
| **Ruby** | >= 2.7.2 |

memoize methods invocation

## [memoized](https://github.com/makandra/memoized)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Barun Singh, Henning Koch |
| **License** | MIT |

Memoized caches the results of your method calls

## [memory](https://github.com/socketry/memory)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | Sam Saffron, Dave Gynn, Samuel Williams, Nick LaMuro, Jonas Peschla, Ashwin Maroli, Søren Skovsbøll, Richard Schneeman, Anton Davydov, Benoit Tigeot, Jean Boussier, Vincent Woo, Andrew Grimm, Boris Staal, Danny Ben Shitrit, Espartaco Palma, Florian Schwab, Hamdi Akoğuz, Jaiden Mispy, John Bachir, Luís Ferreira, Mike Subelsky, Olle Jonsson, Vasily Kolesnikov, William Tabi, Michael Go |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Memory profiling routines for Ruby 2.3+

**Dependencies:** bake (~> 0.15), console (>= 0), msgpack (>= 0)

## [memory-leak](https://github.com/socketry/memory-leak)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A memory leak monitor.

## [memory_profiler](https://github.com/SamSaffron/memory_profiler)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Sam Saffron |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Memory profiling routines for Ruby 3.1+

## [mercenary](https://github.com/jekyll/mercenary)

| | |
|---|---|
| **Version** | 0.3.6 |
| **Authors** | Tom Preston-Werner, Parker Moore |
| **License** | MIT |

Lightweight and flexible library for writing command-line apps in Ruby.

## [mermaid](https://github.com/seuros/mermaid-ruby)

| | |
|---|---|
| **Version** | 0.0.6 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Generate Diagrams and Flowcharts with Mermaid

**Dependencies:** diagram (>= 0.3.4), zeitwerk (>= 0)

## [message_bus](https://github.com/discourse/message_bus)

| | |
|---|---|
| **Version** | 4.4.1 |
| **Authors** | Sam Saffron |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |


A message bus for rack

**Dependencies:** rack (>= 1.1.3)

## [meta-tags](https://github.com/kpumuk/meta-tags)

| | |
|---|---|
| **Version** | 2.22.3 |
| **Authors** | Dmytro Shteflyuk |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Collection of SEO helpers for Ruby on Rails.

Search Engine Optimization (SEO) plugin for Ruby on Rails applications.

**Dependencies:** actionpack (>= 6.0.0)

## [method_locator](http://github.com/ryanlecompte/method_locator)

| | |
|---|---|
| **Version** | 0.0.4 |
| **Authors** | Ryan LeCompte |

method_locator provides a way to traverse an object's method lookup path to find all places where a method may be defined.

## [method_source](http://banisterfiend.wordpress.com)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | John Mair (banisterfiend) |
| **License** | MIT |

retrieve the sourcecode for a method

## [methodfinder](https://sr.ht/~citizen428/methodfinder/)

| | |
|---|---|
| **Version** | 2.2.5 |
| **Authors** | Michael Kohl |
| **License** | MIT |
| **Ruby** | >= 2.6 |

A Smalltalk-like Method Finder for Ruby

A Smalltalk-like Method Finder for Ruby with some extra features

## [metrics](https://github.com/socketry/metrics)

| | |
|---|---|
| **Version** | 0.15.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Application metrics and instrumentation.

## [middleman](http://middlemanapp.com)

| | |
|---|---|
| **Version** | 4.6.2 |
| **Authors** | Thomas Reynolds, Ben Hollis, Karl Freeman |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Hand-crafted frontend development

A static site generator. Provides dozens of templating languages (Haml, Sass, Slim, CoffeeScript, and more). Makes minification, compression, cache busting, Yaml data (and more) an easy part of your development cycle.

**Dependencies:** middleman-core (= 4.6.2), middleman-cli (= 4.6.2)

## [middleman-cli](http://middlemanapp.com)

| | |
|---|---|
| **Version** | 4.6.2 |
| **Authors** | Thomas Reynolds, Ben Hollis |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Hand-crafted frontend development

A static site generator. Provides dozens of templating languages (Haml, Sass, Slim, CoffeeScript, and more). Makes minification, compression, cache busting, Yaml data (and more) an easy part of your development cycle.

**Dependencies:** thor (>= 0.17.0, < 2)

## [middleman-core](https://middlemanapp.com)

| | |
|---|---|
| **Version** | 4.6.2 |
| **Authors** | Thomas Reynolds, Ben Hollis, Karl Freeman |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Hand-crafted frontend development

A static site generator. Provides dozens of templating languages (Haml, Sass, Slim, CoffeeScript, and more). Makes minification, compression, cache busting, Yaml data (and more) an easy part of your development cycle.

**Dependencies:** bundler (~> 2.0), rack (>= 3), rackup (>= 0), tilt (~> 2.2), erubi (>= 0), haml (>= 4.0.5), coffee-script (~> 2.2), kramdown (~> 2.4), fast_blank (>= 0), parallel (>= 0), servolux (>= 0), dotenv (>= 0), toml (>= 0), webrick (>= 0), activesupport (>= 6.1), padrino-helpers (~> 0.15.0), addressable (~> 2.4), memoist (~> 0.14), listen (~> 3.0), i18n (>= 1.6, < 1.15), fastimage (~> 2.0), sassc (~> 2.0), uglifier (>= 3, < 5), execjs (~> 2.0), contracts (>= 0), hashie (>= 3.4, < 6.0), hamster (~> 3.0)

## [milestoner](https://alchemists.io/projects/milestoner)

| | |
|---|---|
| **Version** | 20.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A command line interface for automated Git repository milestones.

**Dependencies:** asciidoctor (~> 2.0), cff (~> 1.3), cogger (~> 2.0), containable (~> 2.0), core (~> 3.0), dry-monads (~> 1.9), dry-schema (~> 1.15), etcher (~> 4.0), gitt (~> 5.0), hanami-view (~> 2.3), infusible (~> 5.0), lode (~> 3.0), redcarpet (~> 3.6), refinements (~> 14.0), rouge (~> 4.5), rss (~> 0.3), runcom (~> 13.0), sanitize (~> 7.0), sod (~> 2.0), spek (~> 5.0), tone (~> 3.0), versionaire (~> 15.0), zeitwerk (~> 2.7)

## [mime-types](https://github.com/mime-types/ruby-mime-types/)

| | |
|---|---|
| **Version** | 3.7.0 |
| **Authors** | Austin Ziegler |
| **License** | MIT |
| **Ruby** | >= 2.0 |

The mime-types library provides a library and registry for information about MIME content type definitions

The mime-types library provides a library and registry for information about MIME content type definitions. It can be used to determine defined filename extensions for MIME types, or to use filename extensions to look up the likely MIME type definitions.  Version 3.0 is a major release that requires Ruby 2.0 compatibility and removes deprecated functions. The columnar registry format introduced in 2.6 has been made the primary format; the registry data has been extracted from this library and put into [mime-types-data][data]. Additionally, mime-types is now licensed exclusively under the MIT licence and there is a code of conduct in effect. There are a number of other smaller changes described in the History file.

**Dependencies:** mime-types-data (~> 3.2025, >= 3.2025.0507), logger (>= 0)

## [mime-types-data](https://github.com/mime-types/mime-types-data/)

| | |
|---|---|
| **Version** | 3.2026.0203 |
| **Authors** | Austin Ziegler |
| **License** | MIT |
| **Ruby** | >= 2.0 |

mime-types-data provides a registry for information about MIME media type definitions

mime-types-data provides a registry for information about MIME media type definitions. It can be used with the Ruby mime-types library or other software to determine defined filename extensions for MIME types, or to use filename extensions to look up the likely MIME type definitions.  ==== To Install:

## [minds_sdk](https://github.com/tungnt1203/minds_ruby_sdk)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | tungnt |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Minds Ruby SDK provides an interface to interact with the Minds AI system API. It allows you to create and manage "minds" (artificial intelligences), create chat completions, and manage data sources.

Official Ruby SDK for Minds

**Dependencies:** faraday (~> 2.12), ruby-openai (~> 7.3, >= 7.3.1)

## [mini_histogram](https://github.com/zombocom/mini_histogram)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | schneems |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

A small gem for building histograms out of Ruby arrays

It makes histograms out of Ruby data. How cool is that!? Pretty cool if you ask me.

## [mini_i18n](https://github.com/markets/mini_i18n)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | markets |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Minimalistic I18n library for Ruby

Minimalistic I18n library for Ruby. It supports localization, pluralization, interpolations, fallbacks, nested keys and more.

## [mini_magick](https://github.com/minimagick/minimagick)

| | |
|---|---|
| **Version** | 5.3.1 |
| **Authors** | Corey Johnson, Hampton Catlin, Peter Kieltyka, James Miller, Thiago Fernandes Massa, Janko Marohnić |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Manipulate images with minimal use of memory via ImageMagick

**Dependencies:** logger (>= 0)

## [mini_mime](https://github.com/discourse/mini_mime)

| | |
|---|---|
| **Version** | 1.1.5 |
| **Authors** | Sam Saffron |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A minimal mime type library

## [mini_portile2](https://github.com/flavorjones/mini_portile)

| | |
|---|---|
| **Version** | 2.8.9 |
| **Authors** | Luis Lavena, Mike Dalessio, Lars Kanis |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Simple autoconf and cmake builder for developers

Simple autoconf and cmake builder for developers. It provides a standard way to compile against dependency libraries without requiring system-wide installation. It also simplifies vendoring and cross-compilation by providing a consistent build interface.

## [mini_sql](https://github.com/discourse/mini_sql)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Sam Saffron |
| **License** | MIT |

A fast, safe, simple direct SQL executor

A fast, safe, simple direct SQL executor for PG

## [miniapm](https://miniapm.com)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Chris Hasinski |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Lightweight APM client for MiniAPM server

Ruby gem for Rails APM integration with MiniAPM. Exports traces in OTLP format, captures errors, and provides comprehensive instrumentation for Rails, ActiveRecord, Sidekiq, HTTP clients, Redis, and search engines.

## [minima](https://github.com/jekyll/minima)

| | |
|---|---|
| **Version** | 2.5.1 |
| **Authors** | Joel Glovier |
| **License** | MIT |

A beautiful, minimal theme for Jekyll.

**Dependencies:** jekyll (>= 3.5, < 5.0), jekyll-feed (~> 0.9), jekyll-seo-tag (~> 2.1)

## [minitar](https://github.com/halostatue/minitar/)

| | |
|---|---|
| **Version** | 0.12.1 |
| **Authors** | Austin Ziegler |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 1.8 |

The minitar library is a pure-Ruby library that provides the ability to deal with POSIX tar(1) archive files

The minitar library is a pure-Ruby library that provides the ability to deal with POSIX tar(1) archive files.  This is release 0.12. This is likely the last revision before 1.0.  minitar (previously called Archive::Tar::Minitar) is based heavily on code originally written by Mauricio Julio Fernández Pradier for the rpa-base project.

## [minitest](https://minite.st/)

| | |
|---|---|
| **Version** | 5.27.0 |
| **Authors** | Ryan Davis |
| **License** | MIT |
| **Ruby** | >= 3.1 |

minitest provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking

minitest provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking.  "I had a class with Jim Weirich on testing last week and we were allowed to choose our testing frameworks. Kirk Haines and I were paired up and we cracked open the code for a few test frameworks...  I MUST say that minitest is *very* readable / understandable compared to the 'other two' options we looked at. Nicely done and thank you for helping us keep our mental sanity."  -- Wayne E. Seguin  minitest/test is a small and incredibly fast unit testing framework. It provides a rich set of assertions to make your tests clean and readable.  minitest/spec is a functionally complete spec engine. It hooks onto minitest/test and seamlessly bridges test assertions over to spec expectations.  minitest/benchmark is an awesome way to assert the performance of your algorithms in a repeatable manner. Now you can assert that your newb co-worker doesn't replace your linear algorithm with an exponential one!  minitest/mock by Steven Baker, is a beautifully tiny mock (and stub) object framework.  minitest/pride shows pride in testing and adds coloring to your test output. I guess it is an example of how to write IO pipes too. :P  minitest/test is meant to have a clean implementation for language implementors that need a minimal set of methods to bootstrap a working test suite. For example, there is no magic involved for test-case discovery.  "Again, I can't praise enough the idea of a testing/specing framework that I can actually read in full in one sitting!"  -- Piotr Szotkowski  Comparing to rspec:  rspec is a testing DSL. minitest is ruby.  -- Adam Hawkins, "Bow Before MiniTest"  minitest doesn't reinvent anything that ruby already provides, like: classes, modules, inheritance, methods. This means you only have to learn ruby to use minitest and all of your regular OO practices like extract-method refactorings still apply.

## [minitest-difftastic](https://github.com/marcoroth/minitest-difftastic)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Marco Roth |
| **Ruby** | >= 3.1.0 |

Minitest Plugin to use difftastic for failed assertions

**Dependencies:** difftastic (~> 0.6)

## [minitest-ok](https://github.com/kwatch/minitest-ok)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | makoto kuwata |
| **License** | MIT-License |
| **Ruby** | >= 1.9 |

'ok {1+1} == 2' instead of 'assert_equal 2, 1+1'

Using Minitest::Ok, you can write:  * 'ok {1+1} == 2' instead of 'assert_equal 2, 1+1', * 'ok {1+1} > 0' instead of 'assert_operator 1+1, :>, 0', * 'ok {5}.in?(1..9)' instead of 'assert_include 1..9, 5',  and so on.

**Dependencies:** minitest (>= 0)

## [minitest-power_assert](https://github.com/hsbt/minitest-power_assert)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | SHIBATA Hiroshi |
| **License** | 2-clause BSDL |

Power Assert for Minitest.

**Dependencies:** minitest (>= 0), power_assert (>= 1.1)

## [minitest-rails](http://minitest.github.io/minitest-rails/)

| | |
|---|---|
| **Version** | 8.1.0 |
| **Authors** | Mike Moore |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Minitest integration for Rails

Adds Minitest as the default testing library in Rails

**Dependencies:** minitest (~> 5.20), railties (>= 8.1.0, < 8.2.0)

## [minitest-reporters](https://github.com/minitest-reporters/minitest-reporters)

| | |
|---|---|
| **Version** | 1.7.1 |
| **Authors** | Alexander Kern |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Create customizable Minitest output formats

Death to haphazard monkey-patching! Extend Minitest through simple hooks.

**Dependencies:** minitest (>= 5.0), ansi (>= 0), ruby-progressbar (>= 0), builder (>= 0)

## [minitest-reporters-llm](https://github.com/seuros/minitest-reporters-llm)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3 |

Token-optimized Minitest reporter for LLM consumption with regression tracking

A Minitest reporter optimized for Large Language Model consumption, featuring compact emoji-based output, regression detection by comparing test runs, TOML report generation, and detailed failure reporting with file locations. Perfect for AI-assisted development workflows.

**Dependencies:** minitest (>= 5.25), minitest-reporters (>= 1.7.1)

## [minitest-rerun-failed](https://www.github.com/houen/minitest-rerun-failed)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Søren Houen |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Easily rerun failed tests with Minitest

**Dependencies:** minitest (~> 5.0, >= 5.0.0), minitest-reporters (~> 1.4, >= 1.4.0)

## [mission_control](https://rubygems.org/gems/mission_control)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | maciej@mensfeld.pl |

Apollo 11 Mission Control Guidance Computer (AGC) Ruby implementation

## [mission_control-jobs](https://github.com/rails/mission_control-jobs)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Jorge Manrubia |
| **License** | MIT |

Operational controls for Active Job

**Dependencies:** activerecord (>= 7.1), activejob (>= 7.1), actionpack (>= 7.1), actioncable (>= 7.1), railties (>= 7.1), importmap-rails (>= 1.2.1), turbo-rails (>= 0), stimulus-rails (>= 0), irb (~> 1.13)

## [mister_bin](https://github.com/dannyben/mister_bin)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Command line interface for your gems

Easily add command line interface to your gems

**Dependencies:** colsole (~> 1.0.0), docopt_ng (~> 0.7.1), reline (~> 0.6)

## [mistral](https://github.com/wilsonsilva/mistral)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Wilson Silva |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

A Ruby client for the Mistral AI platform

A 1:1 Ruby port of the official Mistral Python client, with feature and API parity.

**Dependencies:** dry-struct (~> 1.6), http (~> 5.2)

## [mistral-ai](https://github.com/gbaptista/mistral-ai)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | gbaptista |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Interact with Mistral AI.

A Ruby gem for interacting with Mistral AI's large language models.

**Dependencies:** event_stream_parser (~> 1.0), faraday (~> 2.9), faraday-typhoeus (~> 1.1)

## [mitie](https://github.com/ankane/mitie-ruby)

| | |
|---|---|
| **Version** | 0.3.3 |
| **Authors** | Andrew Kane |
| **License** | BSL-1.0 |
| **Ruby** | >= 3.1 |

Named-entity recognition for Ruby

**Dependencies:** fiddle (>= 0)

## [mittsu](https://github.com/danini-the-panini/mittsu)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Danielle Smith |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

3D Graphics Library for Ruby

Mittsu is a 3D Graphics Library for Ruby, based heavily on Three.js

**Dependencies:** chunky_png (>= 0)

## [mixlib-cli](https://github.com/chef/mixlib-cli)

| | |
|---|---|
| **Version** | 2.1.8 |
| **Authors** | Chef Software, Inc. |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.4 |

A simple mixin for CLI interfaces, including option parsing

## [mixlib-config](https://github.com/chef/mixlib-config)

| | |
|---|---|
| **Version** | 3.0.27 |
| **Authors** | Chef Software, Inc. |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.5 |

A class based configuration library

**Dependencies:** tomlrb (>= 0)

## [mixlib-install](https://github.com/chef/mixlib-install)

| | |
|---|---|
| **Version** | 3.15.0 |
| **Authors** | Thom May, Patrick Wright |
| **License** | Apache-2.0 |

A library for interacting with Chef Software Inc's software distribution systems.

**Dependencies:** mixlib-shellout (>= 0), mixlib-versioning (>= 0), thor (>= 0)

## [mixlib-log](https://github.com/chef/mixlib-log)

| | |
|---|---|
| **Version** | 3.2.3 |
| **Authors** | Chef Software, Inc. |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

A gem that provides a simple mixin for log functionality

**Dependencies:** ffi (>= 1.15.5)

## [mixlib-shellout](https://github.com/chef/mixlib-shellout)

| | |
|---|---|
| **Version** | 3.3.9 |
| **Authors** | Chef Software Inc. |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Run external commands on Unix or Windows

**Dependencies:** chef-utils (>= 0)

## [mixlib-versioning](https://github.com/chef/mixlib-versioning)

| | |
|---|---|
| **Version** | 1.2.12 |
| **Authors** | Seth Chisamore, Christopher Maier |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.0 |

General purpose Ruby library that allows you to parse, compare and manipulate version strings in multiple formats.

## [mize](https://github.com/flori/mize)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Florian Frank |
| **License** | MIT |
| **Ruby** | >= 2 |

Library that provides memoziation for methods and functions

Library that provides memoziation for methods and functions for Ruby.

## [mkbrut](https://brutrb.com)

| | |
|---|---|
| **Version** | 0.17.0 |
| **Authors** | Dave Copeland |

Create a new Brut App

mkbrut is how you go from zero to having a Brut app where you can start working.

## [mmh3](https://github.com/yoshoku/mmh3)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | yoshoku |
| **License** | MIT |

A pure Ruby implementation of MurmurHash3

## [mocha](https://mocha.jamesmead.org)

| | |
|---|---|
| **Version** | 3.0.1 |
| **Authors** | James Mead |
| **License** | MIT, BSD-2-Clause |
| **Ruby** | >= 2.2 |

Mocking and stubbing library

A library for mocking and stubbing with a unified, simple and readable syntax for both full & partial mocking. Built-in support for Minitest and Test::Unit. Supported by many other test frameworks, e.g. RSpec.

**Dependencies:** ruby2_keywords (>= 0.0.5)

## [mock_redis](https://github.com/sds/mock_redis)

| | |
|---|---|
| **Version** | 0.53.0 |
| **Authors** | Shane da Silva, Samuel Merritt |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Redis mock that just lives in memory; useful for testing.

Instantiate one with `redis = MockRedis.new` and treat it like you would a normal Redis object. It supports all the usual Redis operations.

**Dependencies:** redis (~> 5)

## [model-context-protocol-rb](https://github.com/dickdavis/model-context-protocol-rb)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Dick Davis |
| **License** | MIT |
| **Ruby** | >= 3.2.4 |

An implementation of the Model Context Protocol (MCP) in Ruby.

**Dependencies:** json-schema (~> 5.1), addressable (~> 2.8), redis (~> 5.0), connection_pool (~> 3.0), concurrent-ruby (~> 1.3)

## [model-to-schema](https://github.com/sergiobayona/esquema)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Sergio Bayona |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Generate json-schema from ActiveRecord models.

## [modelcontextprotocol](https://github.com/terminalwire/modelcontextprotocol)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Brad Gessler |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Wrap Thor command-line apps in model view context protocol

Enable model view context protocol for Thor command-line apps.

## [module_methods](https://github.com/AlexWayfer/module_methods)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Alexander Popov |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Extendable module for modules with instance and class methods.

Extendable module for modules with instance and class methods. These modules can be included into each other modules and saving all chain, including `inherited` or `included` (class) methods.

## [monetize](https://github.com/RubyMoney/monetize)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Shane Emmons, Anthony Dmitriyev |
| **License** | MIT |
| **Ruby** | >= 3.1 |

A library for converting various objects into `Money` objects.

**Dependencies:** money (~> 7.0)

## [money](https://rubymoney.github.io/money)

| | |
|---|---|
| **Version** | 6.19.0 |
| **Authors** | Shane Emmons, Anthony Dmitriyev |
| **License** | MIT |

A Ruby Library for dealing with money and currency conversion.

**Dependencies:** i18n (>= 0.6.4, <= 2)

## [money-collection](https://github.com/RubyMoney/money-collection)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | lulalala |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Optimized operation on collection of Money objects

**Dependencies:** money (~> 7.0)

## [money-heuristics](https://rubymoney.github.io/money-heuristics)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Shane Emmons, Anthony Dmitriyev |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Heuristic module for the money gem

Heuristic module for analyzing currency information from strings for the money gem. It was formerly part of the money gem.

**Dependencies:** sixarm_ruby_unaccent (>= 1.1.1, < 2), money (~> 7.0)

## [money-rails](https://github.com/RubyMoney/money-rails)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Andreas Loupasakis, Shane Emmons, Simone Carletti |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Money gem integration with Rails

This library provides integration of RubyMoney - Money gem with Rails

**Dependencies:** money (~> 7.0), monetize (~> 2.0), activesupport (>= 7.0), railties (>= 7.0)

## [mongo](http://www.mongodb.org)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Jim Menard, Mike Dirolf, Kyle Banker |

Ruby driver for the MongoDB

A Ruby driver for MongoDB. For more information about Mongo, see http://www.mongodb.org.

**Dependencies:** bson (>= 1.3.1)

## [monkeyspaw](https://github.com/sublayerapp/monkeyspaw)

| | |
|---|---|
| **Version** | 0.0.4 |
| **Authors** | Scott Werner |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A prompt-driven web framework for Ruby - be careful what you wish for

MonkeysPaw is a micro web framework that grants your wishes through AI prompts, but as with any wish-granting entity, the clarity of your request determines what you receive. Craft your prompts with care, lest your website manifest in unexpected ways.

**Dependencies:** rack (~> 3.1), puma (~> 6.6), sublayer (~> 0.2.8)

## [mono_logger](http://github.com/steveklabnik/mono_logger)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Steve Klabnik |
| **License** | MIT |

A lock-free logger compatible with Ruby 2.0.

A lock-free logger compatible with Ruby 2.0. Ruby does not allow you to request a lock in a trap handler because that could deadlock, so Logger is not sufficient.

## [monotime](https://github.com/Freaky/monotime)

| | |
|---|---|
| **Version** | 0.8.2 |
| **Authors** | Thomas Hurst |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A sensible interface to the monotonic clock

## [more_math](https://github.com/flori/more_math)

| | |
|---|---|
| **Version** | 1.11.0 |
| **Authors** | Florian Frank |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Library that provides more mathematics.

Library that provides more mathematical functions/algorithms than standard Ruby.

**Dependencies:** tins (~> 1), mize (>= 0)

## [motor-admin](https://rubygems.org/gems/motor-admin)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Pete Matsyburka |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Low-code Admin panel and Business intelligence

Motor Admin allows to create a flexible admin panel with writing less code. All customizations to the admin panel can be made directly in the UI without the need of writing any configurations code.

**Dependencies:** ar_lazy_preload (~> 1.0), audited (~> 5.0), cancancan (~> 3.0), fugit (~> 1.0), rails (>= 5.2), csv (>= 3.0)

## [msgpack](http://msgpack.org/)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Sadayuki Furuhashi, Theo Hultberg, Satoshi Tagomori |
| **License** | Apache 2.0 |
| **Ruby** | >= 2.5 |

MessagePack, a binary-based efficient data interchange format.

MessagePack is a binary-based efficient object serialization library. It enables to exchange structured objects between many languages like JSON. But unlike JSON, it is very fast and small.

## [mudis](https://github.com/kiebor81/mudis)

| | |
|---|---|
| **Version** | 0.9.4 |
| **Authors** | kiebor81 |
| **License** | MIT |
| **Ruby** | >= 3.3 |

A fast in-memory, thread-safe and high performance Ruby LRU cache with compression and auto-expiry.

Mudis is a fast, thread-safe, in-memory, sharded LRU cache for Ruby applications. Inspired by Redis, it provides value serialization, optional compression, per-key expiry, and metric tracking in a lightweight, dependency-free package.

## [multi_json](https://github.com/sferik/multi_json)

| | |
|---|---|
| **Version** | 1.19.1 |
| **Authors** | Michael Bleigh, Josh Kalderimis, Erik Berlin, Pavel Pravosud |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A common interface to multiple JSON libraries.

A common interface to multiple JSON libraries, including fast_jsonparser, Oj, Yajl, the JSON gem (with C-extensions), gson, JrJackson, and OkJson.

## [multi_test](http://cukes.info)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Matt Wynne, Steve Tooke |
| **License** | MIT |
| **Ruby** | >= 2.0 |

multi-test-1.1.0

Wafter-thin gem to help control rogue test/unit/autorun requires

## [multi_xml](https://github.com/sferik/multi_xml)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Erik Berlin |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provides swappable XML backends utilizing LibXML, Nokogiri, Ox, or REXML.

**Dependencies:** bigdecimal (>= 3.1, < 5)

## [multipart-post](https://github.com/socketry/multipart-post)

| | |
|---|---|
| **Version** | 2.4.1 |
| **Authors** | Nick Sieger, Samuel Williams, Olle Jonsson, McClain Looney, Lewis Cowles, Gustav Ernberg, Patrick Davey, Steven Davidovitz, Alex Koppel, Ethan Turkeltaub, Jagtesh Chadha, Jason York, Tohru Hashimoto, Vincent Pellé, hexfet, Christine Yen, David Moles, Eric Hutzelman, Feuda Nan, Gerrit Riessen, Jan Piotrowski, Jan-Joost Spanjers, Jason Moore, Jeff Hodges, Johannes Wagener, Jordi Massaguer Pla, Lachlan Priest, Leo Cassarani, Lonre Wang, Luke Redpath, Masato Nakamura, Matt Colyer, Mislav Marohnić, Peter Goldstein, Socrates Vicente, Steffen Grunwald, Takuya Noguchi, Tim Barkley |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A multipart form post accessory for Net::HTTP.

## [mupdf](https://github.com/ksylvest/mupdf)

| | |
|---|---|
| **Version** | 1.0.4 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A library for interacting with MuPDF.

Integrate with MuPDF for analyzing and converting PDFs.

**Dependencies:** bigdecimal (>= 0), open3 (>= 0), zeitwerk (>= 0)

## [murmurhash3](https://github.com/funny-falcon/murmurhash3-ruby)

| | |
|---|---|
| **Version** | 0.1.7 |
| **Authors** | Sokolov Yura 'funny-falcon' |
| **License** | MIT |
| **Ruby** | >= 1.9.1 |

implements mumur3 hashing function

implementation of murmur3 hashing function

## [mustache](https://github.com/mustache/mustache)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Chris Wanstrath, Magnus Holm, Pieter van de Bruggen, Ricardo Mendes |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Mustache is a framework-agnostic way to render logic-free views.

Inspired by ctemplate, Mustache is a framework-agnostic way to render logic-free views.  As ctemplates says, "It emphasizes separating logic from presentation: it is impossible to embed application logic in this template language.  Think of Mustache as a replacement for your views. Instead of views consisting of ERB or HAML with random helpers and arbitrary logic, your views are broken into two parts: a Ruby class and an HTML template.

## [mustache-sinatra](https://github.com/mustache/mustache-sinatra)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Ricardo Mendes |
| **License** | MIT |

Mustache support for Sinatra applications

**Dependencies:** mustache (~> 1.0)

## [mustermann](https://github.com/sinatra/mustermann)

| | |
|---|---|
| **Version** | 3.0.4 |
| **Authors** | Konstantin Haase, Zachary Scott |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Your personal string matching expert.

A library implementing patterns that behave like regular expressions.

**Dependencies:** ruby2_keywords (~> 0.0.1)

## [mutex_m](https://github.com/ruby/mutex_m)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Keiju ISHITSUKA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5 |

Mixin to extend objects to be handled like a Mutex.

## [my_news](https://github.com/madbomber/my_news)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

RSS feed pipeline that transforms feeds into themed bulletins

Fetches, normalizes, summarizes, clusters, and publishes RSS feeds as themed bulletins

**Dependencies:** sequel (~> 5.0), sqlite3 (~> 2.0), async (~> 2.0), async-http (~> 0.75), rss (~> 0.3), thor (~> 1.3), myway_config (>= 0), nokogiri (~> 1.16), reverse_markdown (~> 2.1), ruby_llm (~> 1.0), faraday (~> 2.0), rufus-scheduler (~> 3.9), ruby-progressbar (~> 1.13), classifier (~> 2.2)

## [myway_config](https://github.com/madbomber/myway_config)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Configuration management extending anyway_config with XDG support and auto-configuration

MywayConfig extends anyway_config with XDG config file loading, bundled defaults, and auto-configuration from YAML. Define your config structure once in YAML and access values using method syntax, bracket notation, or Hash-like enumeration.

**Dependencies:** anyway_config (>= 2.0)

## [n1_loader](https://github.com/djezzzl/n1_loader)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Evgeniy Demin |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Loader to solve N+1 issue for good.

**Dependencies:** mutex_m (>= 0)

## [n_plus_one_control](https://github.com/palkan/n_plus_one_control)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | palkan |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

RSpec and Minitest matchers to prevent N+1 queries problem

RSpec and Minitest matchers to prevent N+1 queries problem.  Evaluates code under consideration several times with different scale factors to make sure that the number of DB queries behaves as expected (i.e. O(1) instead of O(N)).

## [nano-bots](https://github.com/icebaker/ruby-nano-bots)

| | |
|---|---|
| **Version** | 3.4.0 |
| **Authors** | icebaker |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Ruby Implementation of Nano Bots: small, AI-powered bots for OpenAI ChatGPT, Ollama, Mistral AI, Anthropic Claude, Cohere Command, Maritaca AI MariTalk, and Google Gemini.

Ruby Implementation of Nano Bots: small, AI-powered bots that can be easily shared as a single file, designed to support multiple providers such as OpenAI ChatGPT, Ollama, Mistral AI, Cohere Command, Maritaca AI MariTalk, and Google Gemini, with support for calling Tools (Functions).

**Dependencies:** babosa (~> 2.0), concurrent-ruby (~> 1.3, >= 1.3.3), dotenv (~> 3.1, >= 3.1.2), pry (~> 0.14.2), rainbow (~> 3.1, >= 3.1.1), rbnacl (~> 7.1, >= 7.1.1), redcarpet (~> 3.6), sweet-moon (~> 1.0), anthropic (~> 0.3.0), cohere-ai (~> 1.1), gemini-ai (~> 4.1), maritaca-ai (~> 1.2), mistral-ai (~> 1.2), ollama-ai (~> 1.2, >= 1.2.1), ruby-openai (~> 7.1), faraday (~> 2.9, >= 2.9.2), faraday-typhoeus (~> 1.1), typhoeus (~> 1.4, >= 1.4.1)

## [nanoid](https://github.com/radeno/nanoid.rb)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Radovan Smitala |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Ruby implementation of Nanoid, secure URL-friendly unique ID generator

## [nap](https://github.com/Fingertips/nap)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Manfred Stienstra |
| **License** | MIT |

Nap is a really simple REST library.

Nap is a really simple REST library. It allows you to perform HTTP requests with minimal amounts of code.

## [narray](http://masa16.github.io/narray/)

| | |
|---|---|
| **Version** | 0.6.1.2 |
| **Authors** | Masahiro Tanaka |
| **License** | Ruby |

N-dimensional Numerical Array class for Ruby

Numerical N-dimensional Array class

## [native-package-installer](https://github.com/ruby-gnome/native-package-installer)

| | |
|---|---|
| **Version** | 1.1.9 |
| **Authors** | Kouhei Sutou |
| **License** | LGPL-3+ |

native-package-installer helps to install native packages on "gem install"

Users need to install native packages to install an extension library that depends on native packages. It bores users because users need to install native packages and an extension library separately.  native-package-installer helps to install native packages on "gem install". Users can install both native packages and an extension library by one action, "gem install".

## [nats-pure](https://nats.io)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Waldemar Quevedo |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

NATS is an open-source, high-performance, lightweight cloud messaging system.

**Dependencies:** concurrent-ruby (~> 1.0), uri (>= 0), securerandom (>= 0), json (>= 0), base64 (>= 0)

## [natto](https://github.com/buruzaemon/natto)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Brooke M. Fujita |
| **License** | BSD |
| **Ruby** | >= 1.9 |

A gem leveraging FFI (foreign function interface), natto combines the Ruby programming language with MeCab, the part-of-speech and morphological analyzer for the Japanese language.

natto provides a naturally Ruby-esque interface to MeCab. It runs on both CRuby (mri/yarv) and JRuby (jvm). It works with MeCab installations on Windows, Unix/Linux, and OS X. No compiler is necessary, as natto is not a C extension.

**Dependencies:** ffi (>= 1.9.0)

## [naturally](http://github.com/public-law/naturally)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Robb Shecter |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Sorts numbers according to the way people are used to seeing them.

Natural Sorting with support for legal numbering, course numbers, and other number/letter mixes.

## [necromancer](https://github.com/piotrmurach/necromancer)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Conversion from one object type to another with a bit of black magic.

## [neighbor](https://github.com/ankane/neighbor)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Nearest neighbor search for Rails

**Dependencies:** activerecord (>= 7.1)

## [nenv](https://github.com/e2/nenv)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Cezary Baginski |
| **License** | MIT |

Convenience wrapper for Ruby's ENV

Using ENV is like using raw SQL statements in your code. We all know how that ends...

## [neo4j-ruby-driver](https://github.com/neo4jrb/neo4j-ruby-driver)

| | |
|---|---|
| **Version** | 4.4.6 |
| **Authors** | Heinrich Klobuczek |
| **License** | MIT |
| **Ruby** | >= 3.1 |


**Dependencies:** activesupport (>= 5.2.0), zeitwerk (>= 2.1.10), async (< 2.13), async-io (>= 0), connection_pool (>= 0)

## [neovim](https://github.com/neovim/neovim-ruby)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Alex Genco |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

A Ruby client for Neovim

**Dependencies:** msgpack (~> 1.1), multi_json (~> 1.0)

## [nested_form](http://github.com/ryanb/nested_form)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Ryan Bates, Andrea Singh |

Gem to conveniently handle multiple models in a single form.

Gem to conveniently handle multiple models in a single form with Rails 3 and jQuery or Prototype.

## [net-ftp](https://github.com/ruby/net-ftp)

| | |
|---|---|
| **Version** | 0.3.9 |
| **Authors** | Shugo Maeda |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

Support for the File Transfer Protocol.

**Dependencies:** net-protocol (>= 0), time (>= 0)

## [net-http](https://github.com/ruby/net-http)

| | |
|---|---|
| **Version** | 0.9.1 |
| **Authors** | NARUSE, Yui |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

HTTP client api for Ruby.

**Dependencies:** uri (>= 0.11.1)

## [net-http-digest_auth](http://github.com/drbrain/net-http-digest_auth)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Eric Hodel |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

An implementation of RFC 2617 - Digest Access Authentication

An implementation of RFC 2617 - Digest Access Authentication.  At this time the gem does not drop in to Net::HTTP and can be used for with other HTTP clients.  In order to use net-http-digest_auth you'll need to perform some request wrangling on your own.  See the class documentation at Net::HTTP::DigestAuth for an example.

## [net-http-persistent](https://github.com/drbrain/net-http-persistent)

| | |
|---|---|
| **Version** | 4.0.8 |
| **Authors** | Eric Hodel |
| **License** | MIT |
| **Ruby** | >= 2.4 |

Manages persistent connections using Net::HTTP including a thread pool for connecting to multiple hosts

Manages persistent connections using Net::HTTP including a thread pool for connecting to multiple hosts.  Using persistent HTTP connections can dramatically increase the speed of HTTP. Creating a new HTTP connection for every request involves an extra TCP round-trip and causes TCP congestion avoidance negotiation to start over.  Net::HTTP supports persistent connections with some API methods but does not make setting up a single persistent connection or managing multiple connections easy.  Net::HTTP::Persistent wraps Net::HTTP and allows you to focus on how to make HTTP requests.

**Dependencies:** connection_pool (>= 2.2.4, < 4)

## [net-http2](http://github.com/ostinelli/net-http2)

| | |
|---|---|
| **Version** | 0.19.0 |
| **Authors** | Roberto Ostinelli |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

NetHttp2 is an HTTP2 client for Ruby.

**Dependencies:** http-2 (>= 1.0)

## [net-imap](https://github.com/ruby/net-imap)

| | |
|---|---|
| **Version** | 0.6.2 |
| **Authors** | Shugo Maeda, nicholas a. evans |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.2.0 |

Ruby client api for Internet Message Access Protocol

**Dependencies:** net-protocol (>= 0), date (>= 0)

## [net-pop](https://github.com/ruby/net-pop)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |

Ruby client library for POP3.

**Dependencies:** net-protocol (>= 0)

## [net-protocol](https://github.com/ruby/net-protocol)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

The abstract interface for net-* client.

**Dependencies:** timeout (>= 0)

## [net-scp](https://github.com/net-ssh/net-scp)

| | |
|---|---|
| **Version** | 4.1.0 |
| **Authors** | Jamis Buck, Delano Mandelbaum, Miklós Fazekas |
| **License** | MIT |

A pure Ruby implementation of the SCP client protocol.

A pure Ruby implementation of the SCP client protocol

**Dependencies:** net-ssh (>= 2.6.5, < 8.0.0)

## [net-sftp](https://github.com/net-ssh/net-sftp)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Jamis Buck, Delano Mandelbaum, Miklós Fazekas |
| **License** | MIT |

A pure Ruby implementation of the SFTP client protocol.

A pure Ruby implementation of the SFTP client protocol

**Dependencies:** net-ssh (>= 5.0.0, < 8.0.0)

## [net-smtp](https://github.com/ruby/net-smtp)

| | |
|---|---|
| **Version** | 0.5.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

Simple Mail Transfer Protocol client library for Ruby.

**Dependencies:** net-protocol (>= 0)

## [net-ssh](https://github.com/net-ssh/net-ssh)

| | |
|---|---|
| **Version** | 7.3.0 |
| **Authors** | Jamis Buck, Delano Mandelbaum, Miklós Fazekas |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Net::SSH: a pure-Ruby implementation of the SSH2 client protocol.

Net::SSH: a pure-Ruby implementation of the SSH2 client protocol. It allows you to write programs that invoke and interact with processes on remote servers, via SSH2.

## [net-ssh-gateway](https://github.com/net-ssh/net-ssh-gateway)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Jamis Buck, Delano Mandelbaum, Miklós Fazekas |
| **License** | MIT |

A simple library to assist in establishing tunneled Net::SSH connections

**Dependencies:** net-ssh (>= 4.0.0)

## [netaddr](https://github.com/dspinhirne/netaddr-rb)

| | |
|---|---|
| **Version** | 2.0.6 |
| **Authors** | Dustin Spinhirne |
| **License** | Apache-2.0 |

A Ruby library for performing calculations on IPv4 and IPv6 subnets.

## [netrc](https://github.com/geemus/netrc)

| | |
|---|---|
| **Version** | 0.11.0 |
| **Authors** | Keith Rarick, geemus (Wesley Beary) |
| **License** | MIT |

Library to read and write netrc files.

This library can read and update netrc files, preserving formatting including comments and whitespace.

## [next_rails](https://github.com/fastruby/next_rails)

| | |
|---|---|
| **Version** | 1.4.6 |
| **Authors** | Ernesto Tagwerker, Luis Sagastume |
| **License** | MIT |
| **Ruby** | >= 2.0 |

A toolkit to upgrade your next Rails application

A set of handy tools to upgrade your Rails application and keep it up to date

**Dependencies:** rainbow (>= 3)

## [nextgen](https://github.com/mattbrictson/nextgen)

| | |
|---|---|
| **Version** | 0.38.0 |
| **Authors** | Matt Brictson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Generate your next Rails app interactively!

Nextgen is an interactive and flexible alternative to `rails new` that includes opt-in support for modern frontend development with Vite.

**Dependencies:** railties (~> 8.1.0), thor (~> 1.2), tty-prompt (~> 0.23.1), tty-screen (~> 0.8.1), zeitwerk (~> 2.6)

## [nio4r](https://github.com/socketry/nio4r)

| | |
|---|---|
| **Version** | 2.7.5 |
| **Authors** | Tony Arcieri, Samuel Williams, Olle Jonsson, Gregory Longtin, Tiago Cardoso, Joao Fernandes, Thomas Dziedzic, Boaz Segev, Logan Bowers, Pedro Paiva, Jun Aruga, Omer Katz, Upekshe Jayasekera, Tim Carey-Smith, Benoit Daloze, Sergey Avseyev, Tomoya Ishida, Usaku Nakamura, Cédric Boutillier, Daniel Berger, Dirkjan Bussink, Hiroshi Shibata, Jesús Burgos Maciá, Luis Lavena, Pavel Rosický, Sadayuki Furuhashi, Stephen von Takach, Vladimir Kochnev, Vít Ondruch, Anatol Pomozov, Bernd Ahlers, Charles Oliver Nutter, Denis Washington, Elad Eyal, Jean byroot Boussier, Jeffrey Martin, John Thornton, Jun Jiang, Lars Kanis, Marek Kowalcze, Maxime Demolin, Orien Madgwick, Pavel Lobashov, Per Lundberg, Phillip Aldridge, Ravil Bayramgalin, Shannon Skipper, Tao Luo, Thomas Kuntz, Tsimnuj Hawj, Zhang Kang |
| **License** | MIT, BSD-2-Clause |
| **Ruby** | >= 2.6 |

New IO for Ruby

## [nkeys](https://nats.io)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Waldemar Quevedo |
| **License** | MIT |

NKEYS for Ruby

NATS Keys for Ruby

**Dependencies:** ed25519 (~> 1.2), base32 (~> 0.3)

## [nkf](https://github.com/ruby/nkf)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | NARUSE Yui, Charles Oliver Nutter |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Ruby extension for Network Kanji Filter

## [no_proxy_fix](https://github.com/ermaker/no_proxy_fix)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Minwoo Lee |
| **License** | MIT |

A fix for a no_proxy bug on ruby 2.4.0 and 2.4.1

A fix for a no_proxy bug: https://github.com/ruby/ruby/commit/556e3da4216c926e71dea9ce4ea4a08dcfdc1275

## [node_mutation](https://github.com/synvert-hq/node-mutation-ruby)

| | |
|---|---|
| **Version** | 1.25.0 |
| **Authors** | Richard Huang |
| **Ruby** | >= 2.7.0 |

ast node mutation apis

## [node_query](https://github.com/synvert-hq/node-query-ruby)

| | |
|---|---|
| **Version** | 1.17.0 |
| **Authors** | Richard Huang |
| **Ruby** | >= 2.7.0 |

ast node query language

## [node_visitor](https://github.com/synvert-hq/node-visitor-ruby)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Richard Huang |
| **Ruby** | >= 2.6.0 |

visit ast nodes

## [nokogiri](https://nokogiri.org)

| | |
|---|---|
| **Version** | 1.18.10 |
| **Authors** | Mike Dalessio, Aaron Patterson, Yoko Harada, Akinori MUSHA, John Shahid, Karol Bucek, Sam Ruby, Craig Barnes, Stephen Checkoway, Lars Kanis, Sergio Arbeo, Timothy Elliott, Nobuyoshi Nakada |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.

Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby. It provides a sensible, easy-to-understand API for reading, writing, modifying, and querying documents. It is fast and standards-compliant by relying on native parsers like libxml2, libgumbo, or xerces.

**Dependencies:** mini_portile2 (~> 2.8.2), racc (~> 1.4)

## [nokolexbor](https://github.com/serpapi/nokolexbor)

| | |
|---|---|
| **Version** | 0.6.2 |
| **Authors** | Yicheng Zhou |
| **License** | MIT |

High-performance HTML5 parser, with support for both CSS selectors and XPath.

Nokolexbor is a high-performance HTML5 parser, with support for both CSS selectors and XPath. It's API is designed to be compatible with Nokogiri.

## [non-digest-assets](http://github.com/mvz/non-digest-assets)

| | |
|---|---|
| **Version** | 2.6.0 |
| **Authors** | Alex Speller, Matijs van Zuijlen |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Make the Rails asset pipeline generate non-digest along with digest assets

Rails provides no option to generate both digest and non-digest assets. Installing this gem automatically creates both digest and non-digest assets which are useful for many reasons.  Currently supports sprockets only.

**Dependencies:** activesupport (>= 6.0, < 8.2), mutex_m (~> 0.3.0), sprockets (~> 4.0)

## [nonschema_migrations](https://github.com/jasonfb/nonschema_migrations)

| | |
|---|---|
| **Version** | 7.0 |
| **Authors** | Jason Fleetwood-Boldt |
| **License** | MIT |

Nonschema(data-only) migrations for your Rails app

Separate schema-only migrations from nonschema (data) migrations in your Rails app

**Dependencies:** rails (>= 7.0, <= 8.2)

## [nori](https://github.com/savonrb/nori)

| | |
|---|---|
| **Version** | 2.7.1 |
| **Authors** | Daniel Harrington, John Nunemaker, Wynn Netherland |
| **License** | MIT |
| **Ruby** | >= 3.0 |

XML to Hash translator

**Dependencies:** bigdecimal (>= 0)

## [noticed](https://github.com/excid3/noticed)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Chris Oliver |
| **License** | MIT |

Notifications for Ruby on Rails applications

Database, browser, realtime ActionCable, Email, SMS, Slack notifications, and more for Rails apps

**Dependencies:** rails (>= 6.1.0)

## [notiffany](https://github.com/guard/notiffany)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Cezary Baginski, Rémy Coutable, Thibaud Guillaume-Gentil |
| **License** | MIT |

Notifier library (extracted from Guard project)

Wrapper libray for most popular notification libraries such as Growl, Libnotify, Notifu

**Dependencies:** nenv (~> 0.1), shellany (~> 0.0)

## [ntcharts](https://github.com/marcoroth/ntcharts-ruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2, < 4.1.dev |

Ruby wrapper for NimbleMarkets' ntcharts terminal charting library.

**Dependencies:** rake-compiler (~> 1.2)

## [nukitori](https://github.com/vifreefly/nukitori)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Victor Afanasev |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Generate reusable XPath schemas with an LLM, then scrape HTML without AI

Nukitori is a Ruby gem for HTML data extraction. It uses an LLM once to generate reusable XPath schemas, then extracts structured data from similarly structured pages using plain Nokogiri. This makes scraping fast, predictable, and cheap for repeated runs.

**Dependencies:** nokogiri (~> 1.19), ruby_llm (~> 1.9, >= 1.9.2)

## [numbers_and_words](http://github.com/kslazarev/numbers_and_words)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Kirill Lazarev |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Spell out numbers in several languages

This gem spells out numbers in several languages using the I18n gem.

**Dependencies:** i18n (<= 2)

## [numo-binrw](https://github.com/himeyama/numo-binrw)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Murata Mitsuharu |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Read binary files and handle them with `NArray`.

**Dependencies:** numo-narray (~> 0.9.2.0)

## [numo-blis](https://github.com/yoshoku/numo-blis)

| | |
|---|---|
| **Version** | 0.5.4 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::BLIS downloads and builds BLIS during installation and uses that as a background library for Numo::Linalg.

Numo::BLIS downloads and builds BLIS during installation and uses that as a background library for Numo::Linalg.

**Dependencies:** fiddle (~> 1.0), numo-linalg (>= 0.1.4)

## [numo-gnuplot](https://github.com/ruby-numo/gnuplot)

| | |
|---|---|
| **Version** | 0.2.4 |
| **Authors** | Masahiro TANAKA |
| **License** | BSD-3-Clause |

Gnuplot interface for Ruby.

Gnuplot interface for Ruby with simple and similar inteface with Gnuplot.

## [numo-liblinear](https://github.com/yoshoku/numo-liblinear)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::Liblinear is a Ruby gem binding to the LIBLINEAR library. Numo::Liblinear makes to use the LIBLINEAR functions with dataset represented by Numo::NArray.

Numo::Liblinear is a Ruby gem binding to the LIBLINEAR library. LIBLINEAR is one of the famous libraries for large-scale regularized linear classification and regression. Numo::Liblinear makes to use the LIBLINEAR functions with dataset represented by Numo::NArray.

**Dependencies:** numo-narray-alt (>= 0.9.10, < 0.11.0)

## [numo-libsvm](https://github.com/yoshoku/numo-libsvm)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::Libsvm is a Ruby gem binding to the LIBSVM library. Numo::Libsvm makes to use the LIBSVM functions with dataset represented by Numo::NArray.

Numo::Libsvm is a Ruby gem binding to the LIBSVM library. LIBSVM is one of the famous libraries that implemented Support Vector Machines, and provides functions for support vector classifier, regression, and distribution estimation. Numo::Libsvm makes to use the LIBSVM functions with dataset represented by Numo::NArray.

**Dependencies:** numo-narray-alt (>= 0.9.10, < 0.11.0)

## [numo-linalg](https://github.com/ruby-numo/numo-linalg)

| | |
|---|---|
| **Version** | 0.1.7 |
| **Authors** | Masahiro TANAKA, Makoto KISHIMOTO |
| **License** | BSD-3-Clause |

Ruby/Numo Linear Algebra library with BLAS/LAPACK

Ruby/Numo Linear Algebra library with interface to BLAS/LAPACK.

**Dependencies:** numo-narray (>= 0.9.1.4)

## [numo-linalg-alt](https://github.com/yoshoku/numo-linalg-alt)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::Linalg Alternative (numo-linalg-alt) is an alternative to Numo::Linalg.

Numo::Linalg Alternative (numo-linalg-alt) is an alternative to Numo::Linalg. Unlike Numo::Linalg, numo-linalg-alt depends on Numo::NArray Alternative (numo-narray-alt).

**Dependencies:** numo-narray-alt (>= 0.9.10, < 0.11.0)

## [numo-linalg-randsvd](https://github.com/yoshoku/numo-linalg-randsvd)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::Linalg.randsvd is a module function on Numo::Linalg for truncated singular value decomposition with randomized algorithm.

Numo::Linalg.randsvd is a module function on Numo::Linalg for truncated singular value decomposition with randomized algorithm.

**Dependencies:** numo-linalg-alt (>= 0.7.1, < 1.0.0), numo-narray-alt (>= 0.9.10, < 0.11.0), numo-random (>= 0.6.2, < 1.0.0)

## [numo-narray](https://github.com/ruby-numo/numo-narray)

| | |
|---|---|
| **Version** | 0.9.2.1 |
| **Authors** | Masahiro TANAKA |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.2 |

alpha release of Numo::NArray - New NArray class library in Ruby/Numo (NUmerical MOdule)

Numo::NArray - New NArray class library in Ruby/Numo.

## [numo-narray-alt](https://github.com/yoshoku/numo-narray-alt)

| | |
|---|---|
| **Version** | 0.9.14 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.2 |

Numo::NArray Alternative is a project forked from Numo::NArray.

Numo::NArray Alternative is a project forked from Numo::NArray. The project aims to support the latest Ruby features, release bug fixes as quickly as possible, and adopt modern development practices.

## [numo-openblas](https://github.com/yoshoku/numo-openblas)

| | |
|---|---|
| **Version** | 0.5.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::OpenBLAS downloads and builds OpenBLAS during installation and uses that as a background library for Numo::Linalg.

Numo::OpenBLAS downloads and builds OpenBLAS during installation and uses that as a background library for Numo::Linalg.

**Dependencies:** numo-linalg (>= 0.1.4)

## [numo-optimize](https://github.com/yoshoku/numo-optimize)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::Optimize provides functions for minimizing objective functions.

**Dependencies:** numo-narray-alt (~> 0.9.9)

## [numo-pocketfft](https://github.com/yoshoku/numo-pocketfft)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::Pocketfft provides functions for descrete Fourier Transform based on pocketfft.

**Dependencies:** numo-narray-alt (>= 0.9.9, < 0.11.0)

## [numo-random](https://github.com/yoshoku/numo-random)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | yoshoku |
| **License** | Apache-2.0 |

Numo::Random provides random number generation with several distributions for Numo::NArray.

**Dependencies:** numo-narray-alt (>= 0.9.10, < 0.11.0)

## [numo-tiny_linalg](https://github.com/yoshoku/numo-tiny_linalg)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Numo::TinyLinalg is a subset library from Numo::Linalg consisting only of methods used in Machine Learning algorithms.

Numo::TinyLinalg is a subset library from Numo::Linalg consisting only of methods used in Machine Learning algorithms. The functions Numo::TinyLinalg supports are dot, det, eigh, inv, pinv, qr, solve, cholesky, cho_solve and svd.

**Dependencies:** numo-narray (>= 0.9.1)

## [numruby](https://github.com/NumRuby/numruby)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Shane Becker |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.4.7 |

NumRuby: Meta-gem for the Ruby scientific ecosystem.

NumRuby is the umbrella gem for a Ruby scientific computing ecosystem inspired by NumPy. It provides a unified namespace for array, linear algebra, statistics, plotting, and other scientific libraries.

## [numruby-linalg](https://github.com/RubyNum/numruby-linalg)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Shane Becker |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.4.7 |

NumRuby: Linear algebra

NumRuby module: Linear algebra

## [numruby-plot](https://github.com/RubyNum/numruby-plot)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Shane Becker |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.4.7 |

NumRuby: visualization layer

NumRuby module: visualization layer

## [numruby-stats](https://github.com/RubyNum/numruby-stats)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Shane Becker |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.4.7 |

NumRuby: Statistics & probability library

NumRuby module: Statistics & probability library

## [numruby-ufunc](https://github.com/RubyNum/numruby-ufunc)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Shane Becker |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.4.7 |

NumRuby: Central ufunc registry and core elementwise ops

NumRuby module: Central ufunc registry and core elementwise ops

## [oas_core](https://github.com/a-chacon/oas_core)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | a-chacon |
| **License** | GPL-3.0-only |
| **Ruby** | >= 3.1 |

Generates OpenAPI Specification (OAS) documents by analyzing and extracting routes from Rails applications.

OasCore simplifies API documentation by automatically generating OpenAPI Specification (OAS 3.1) documents from your Ruby application routes. It eliminates the need for manual documentation, ensuring accuracy and consistency.

**Dependencies:** activesupport (>= 7.0), deep_merge (~> 1.2, >= 1.2.2), method_source (~> 1.0), yard (~> 0.9)

## [oas_rails](https://github.com/a-chacon/oas_rails)

| | |
|---|---|
| **Version** | 1.3.3 |
| **Authors** | a-chacon |
| **License** | MIT |
| **Ruby** | >= 3.1 |

OasRails is a Rails engine for generating automatic interactive documentation for your Rails APIs.

OasRails is a Rails engine for generating automatic interactive documentation for your Rails APIs. It generates an OAS 3.1 document and displays it using RapiDoc.

**Dependencies:** easy_talk_two (~> 1.1.2), oas_core (>= 1.1.0)

## [oauth](https://github.com/ruby-oauth/oauth)

| | |
|---|---|
| **Version** | 1.1.3 |
| **Authors** | Pelle Braendgaard, Blaine Cook, Larry Halff, Jesse Clark, Jon Crosby, Seth Fitzsimmons, Matt Sanford, Aaron Quint, Peter Boling |
| **License** | MIT |
| **Ruby** | >= 2.3 |

🔑 OAuth 1.0 / 1.0a Core Ruby implementation

🔑 A Ruby wrapper for the original OAuth 1.0 / 1.0a spec.

**Dependencies:** oauth-tty (~> 1.0, >= 1.0.6), snaky_hash (~> 2.0), base64 (~> 0.1), version_gem (~> 1.1, >= 1.1.9)

## [oauth-tty](https://github.com/ruby-oauth/oauth-tty)

| | |
|---|---|
| **Version** | 1.0.6 |
| **Authors** | Thiago Pinto, Peter Boling |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

🖥️ OAuth 1.0 / 1.0a TTY CLI

🖥️ OAuth 1.0 / 1.0a TTY Command Line Interface

**Dependencies:** version_gem (~> 1.1, >= 1.1.9)

## [oauth2](https://gitlab.com/oauth-xx/oauth2)

| | |
|---|---|
| **Version** | 1.4.11 |
| **Authors** | Peter Boling, Erik Michaels-Ober, Michael Bleigh |
| **License** | MIT |
| **Ruby** | >= 1.9.0 |

A Ruby wrapper for the OAuth 2.0 protocol.

A Ruby wrapper for the OAuth 2.0 protocol built with a similar style to the original OAuth spec.

**Dependencies:** faraday (>= 0.17.3, < 3.0), jwt (>= 1.0, < 3.0), multi_json (~> 1.3), multi_xml (~> 0.5), rack (>= 1.2, < 4)

## [object_shadow](https://github.com/janlelis/object_shadow)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Metaprogramming Level 2

provides a simple convenient API for accessing an object's state.

## [observer](https://github.com/ruby/observer)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |

Implementation of the Observer object-oriented design pattern.

## [ocassionally](http://github.com/MadBomber/ocassionally)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | You want it, its yours |

Ocassionally it works; and, ocassionally it doesn't

Probabilistic conditionals for fuzziness.

## [occasionally](https://github.com/bradgessler/occasionally)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Brad Gessler |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Run jobs occasionally in Ruby

Occassionally is a lightweight way to run Ruby code periodically in environments that don't have crontab, such as a Docker container

## [octicons](https://github.com/primer/octicons)

| | |
|---|---|
| **Version** | 19.21.2 |
| **Authors** | GitHub Inc. |
| **License** | MIT |

GitHub's octicons gem

A package that distributes Octicons in a gem

## [octokit](https://github.com/octokit/octokit.rb)

| | |
|---|---|
| **Version** | 4.25.1 |
| **Authors** | Wynn Netherland, Erik Michaels-Ober, Clint Shryock |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Ruby toolkit for working with the GitHub API

Simple wrapper for the GitHub API

**Dependencies:** faraday (>= 1, < 3), sawyer (~> 0.9)

## [odf-report](http://sandrods.github.com/odf-report/)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Sandro Duarte |

Generates ODF files, given a template (.odt) and data, replacing tags

**Dependencies:** rubyzip (>= 1.3.0), nokogiri (>= 1.12.0), mime-types (>= 0)

## [ohai](https://github.com/chef/ohai/)

| | |
|---|---|
| **Version** | 19.1.16 |
| **Authors** | Adam Jacob |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Ohai profiles your system and emits JSON

**Dependencies:** base64 (>= 0), chef-config (>= 14.12, < 20), chef-utils (>= 16.0, < 20), ffi (>= 1.15.5), ffi-yajl (~> 2.2), ipaddress (>= 0), mixlib-cli (>= 1.7.0), mixlib-config (>= 2.0, < 4.0), mixlib-log (>= 2.0.1, < 4.0), mixlib-shellout (~> 3.3.6), plist (~> 3.1), train-core (>= 0), wmi-lite (~> 1.0)

## [oj](http://www.ohler.com/oj)

| | |
|---|---|
| **Version** | 3.16.15 |
| **Authors** | Peter Ohler |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A fast JSON parser and serializer.

The fastest JSON parser and object serializer.

**Dependencies:** bigdecimal (>= 3.0), ostruct (>= 0.2)

## [oktest](https://github.com/kwatch/oktest/tree/ruby/ruby)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | kwatch |
| **License** | MIT |
| **Ruby** | >= 2.4 |

a new style testing library

Oktest.rb is a new-style testing library for Ruby. You can write `ok {1+1} == 2` instead of `assert_equal 2, 1+1` or `expect(1+1).to eq 2`.  In addition, Oktest.rb supports **Fixture injection** feature inspired by dependency injection and **JSON Matcher** feature similar to JSON schema.  See https://github.com/kwatch/oktest/tree/ruby/ruby for details.

**Dependencies:** diff-lcs (~> 1.0), benry-cmdopt (~> 2.3), benry-recorder (~> 1.0)

## [ola_maps](https://github.com/shobhit-shukla/ola_maps)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Shobhit |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A Ruby wrapper for the Ola Maps API.

Provides an easy interface for interacting with the Ola Maps API.

**Dependencies:** faraday (~> 2.0), securerandom (>= 0), dotenv (~> 2.7)

## [ollama](https://ollama.ai)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Jeffrey Morgan |
| **License** | MIT |

Ollama

## [ollama-ai](https://github.com/gbaptista/ollama-ai)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | gbaptista |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Interact with Ollama API to run open source AI models locally.

A Ruby gem for interacting with Ollama's API that allows you to run open source AI LLMs (Large Language Models) locally.

**Dependencies:** faraday (~> 2.10), faraday-typhoeus (~> 1.1), typhoeus (~> 1.4, >= 1.4.1)

## [ollama-dsl](https://github.com/rafaelmerlotto/ollama-dsl)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Rafael |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A simple Ruby DSL for interacting with Ollama LLMs, allowing streaming and structured prompts.

Ollama DSL provides an easy-to-use Ruby interface to communicate with Ollama local or remote language models. It supports building prompts with system/user roles, handling streaming responses, and chaining prompts seamlessly.

## [ollama-find](https://github.com/TheNotary/ollama-find)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | TheNotary |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A CLI tool that helps you quickly generate the path to a gguf file cached by Ollama

## [ollama-rb](https://github.com/songjiz/ollama-rb)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | songji.zeng |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ollama Ruby library

The Ollama Ruby library provides the easiest way to integrate your Ruby project with Ollama.

## [omniai](https://github.com/ksylvest/omniai)

| | |
|---|---|
| **Version** | 3.3.3 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A generalized framework for interacting with many AI services

An interface for OpenAI's ChatGPT, Google's Gemini, Anthropic's Claude, Mistral's LeChat, etc.

**Dependencies:** base64 (>= 0), event_stream_parser (>= 0), http (>= 0), logger (>= 0), zeitwerk (>= 0)

## [omniai-anthropic](https://github.com/ksylvest/omniai-anthropic)

| | |
|---|---|
| **Version** | 3.1.1 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A generalized framework for interacting with Anthropic

An implementation of OmniAI for Anthropic

**Dependencies:** event_stream_parser (>= 0), omniai (~> 3.0), openssl (>= 0), zeitwerk (>= 0)

## [omniai-deepseek](https://github.com/ksylvest/omniai-deepseek)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A generalized framework for interacting with DeepSeek

An implementation of OmniAI for DeepSeek

**Dependencies:** event_stream_parser (>= 0), omniai (~> 3.0), zeitwerk (>= 0)

## [omniai-google](https://github.com/ksylvest/omniai-google)

| | |
|---|---|
| **Version** | 3.4.3 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A generalized framework for interacting with Google

An implementation of OmniAI for Google

**Dependencies:** event_stream_parser (>= 0), googleauth (>= 0), google-cloud-storage (>= 0), omniai (~> 3.2), openssl (>= 0), zeitwerk (>= 0)

## [omniai-mistral](https://github.com/ksylvest/omniai-mistral)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A generalized framework for interacting with Mistral

An implementation of OmniAI for Mistral

**Dependencies:** event_stream_parser (>= 0), omniai (~> 3.0), zeitwerk (>= 0)

## [omniai-openai](https://github.com/ksylvest/omniai-openai)

| | |
|---|---|
| **Version** | 3.1.2 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A generalized framework for interacting with OpenAI

An implementation of OmniAI for OpenAI

**Dependencies:** event_stream_parser (>= 0), omniai (~> 3.0), openssl (>= 0), zeitwerk (>= 0)

## [omniai-tools](https://github.com/ksylvest/omniai-tools)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Kevin Sylvestre |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A set of tools built for usage with OmniAI.

These examples can be used for inspiration or directly within an app.

**Dependencies:** omniai (>= 0), zeitwerk (>= 0)

## [omniauth](https://github.com/omniauth/omniauth)

| | |
|---|---|
| **Version** | 2.1.4 |
| **Authors** | Michael Bleigh, Erik Michaels-Ober, Tom Milewski |
| **License** | MIT |
| **Ruby** | >= 2.2 |

A generalized Rack framework for multiple-provider authentication.

**Dependencies:** hashie (>= 3.4.6), rack (>= 2.2.3), rack-protection (>= 0), logger (>= 0)

## [omniauth-oauth2](https://github.com/omniauth/omniauth-oauth2)

| | |
|---|---|
| **Version** | 1.9.0 |
| **Authors** | Michael Bleigh, Erik Michaels-Ober, Tom Milewski |
| **License** | MIT |

An abstract OAuth2 strategy for OmniAuth.

**Dependencies:** oauth2 (>= 2.0.2, < 3), omniauth (~> 2.0)

## [one_time_pad](https://github.com/MadBomber/one_time_pad)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.3 |

A One-Time Pad encryption method for messages.

This gem provides a casually secure (you will never beat the pros) implementation of the One-Time Pad encryption technique, using multiple substitution cyphers suitable for educational and practical use. Knowing the code, you still have approximately 4.3 billion randon seeds to choose from to decode an unknown message.

## [onnxruntime](https://github.com/ankane/onnxruntime-ruby)

| | |
|---|---|
| **Version** | 0.10.1 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

High performance scoring engine for ML models

**Dependencies:** ffi (>= 0)

## [open-uri](https://github.com/ruby/open-uri)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

An easy-to-use wrapper for Net::HTTP, Net::HTTPS and Net::FTP.

**Dependencies:** uri (>= 0), stringio (>= 0), time (>= 0)

## [open3](https://github.com/ruby/open3)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

Popen, but with stderr, too

## [open4](https://github.com/ahoward/open4)

| | |
|---|---|
| **Version** | 1.3.4 |
| **Authors** | Ara T. Howard |
| **License** | Ruby |

open4

open child process with handles on pid, stdin, stdout, and stderr: manage child processes and their io handles easily.

## [open_router](https://github.com/OlympiaAI/open_router)

| | |
|---|---|
| **Version** | 0.3.3 |
| **Authors** | Obie Fernandez |
| **License** | MIT |
| **Ruby** | >= 3.2.2 |

Ruby library for OpenRouter API.

**Dependencies:** activesupport (>= 6.0), dotenv (>= 2), faraday (>= 1), faraday-multipart (>= 1)

## [open_router_usage_tracker](https://github.com/MclPio/open_router_usage_tracker)

| | |
|---|---|
| **Version** | 1.0.4 |
| **Authors** | MclPio |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Track API token usage and cost from multiple LLM providers like OpenRouter, OpenAI, Google, and more.

A simple Rails engine to log API usage from multiple LLM providers and provide methods for tracking user consumption over time, enabling easy rate-limiting.

**Dependencies:** rails (~> 8.0)

## [openai](https://gemdocs.org/gems/openai)

| | |
|---|---|
| **Version** | 0.45.0 |
| **Authors** | OpenAI |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.2.0 |

Ruby library to access the OpenAI API

**Dependencies:** base64 (>= 0), cgi (>= 0), connection_pool (>= 0)

## [openid_connect](https://github.com/nov/openid_connect)

| | |
|---|---|
| **Version** | 2.3.1 |
| **Authors** | nov matake |
| **License** | MIT |

OpenID Connect Server & Client Library

**Dependencies:** tzinfo (>= 0), attr_required (>= 1.0.0), activemodel (>= 0), validate_url (>= 0), email_validator (>= 0), mail (>= 0), faraday (~> 2.0), faraday-follow_redirects (>= 0), json-jwt (>= 1.16), swd (~> 2.0), webfinger (~> 2.0), rack-oauth2 (~> 2.2)

## [opensearch-ruby](https://github.com/opensearch-project/opensearch-ruby)

| | |
|---|---|
| **Version** | 3.4.0 |
| **Authors** | Elastic, OpenSearch Contributors |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.5 |

Ruby Client for OpenSearch

OpenSearch Ruby is a Ruby client for OpenSearch. You can use the client to execute OpenSearch API commands, and build OpenSearch queries and aggregations using the included OpenSearch DSL.

**Dependencies:** faraday (>= 1.0, < 3), multi_json (>= 1.0)

## [openssl](https://github.com/ruby/openssl)

| | |
|---|---|
| **Version** | 3.3.2 |
| **Authors** | Martin Bosslet, SHIBATA Hiroshi, Zachary Scott, Kazuki Yamaguchi |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

SSL/TLS and general-purpose cryptography for Ruby

OpenSSL for Ruby provides access to SSL/TLS and general-purpose cryptography based on the OpenSSL library.

## [opentelemetry-api](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

A stats collection and distributed tracing framework

## [opentelemetry-common](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 0.23.0 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Common helpers for OpenTelemetry

**Dependencies:** opentelemetry-api (~> 1.0)

## [opentelemetry-exporter-otlp](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 0.31.1 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

OTLP exporter for the OpenTelemetry framework

**Dependencies:** googleapis-common-protos-types (~> 1.3), google-protobuf (>= 3.18), opentelemetry-api (~> 1.1), opentelemetry-common (~> 0.20), opentelemetry-sdk (~> 1.10), opentelemetry-semantic_conventions (>= 0)

## [opentelemetry-metrics-api](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

A stats collection and distributed tracing framework

**Dependencies:** opentelemetry-api (~> 1.0)

## [opentelemetry-metrics-sdk](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 0.11.2 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

A stats collection and distributed tracing framework

**Dependencies:** opentelemetry-api (~> 1.1), opentelemetry-metrics-api (~> 0.2), opentelemetry-sdk (~> 1.2)

## [opentelemetry-registry](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Registry for the OpenTelemetry Instrumentation Libraries

**Dependencies:** opentelemetry-api (~> 1.1)

## [opentelemetry-sdk](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

A stats collection and distributed tracing framework

**Dependencies:** opentelemetry-api (~> 1.1), opentelemetry-common (~> 0.20), opentelemetry-registry (~> 0.2), opentelemetry-semantic_conventions (>= 0)

## [opentelemetry-semantic_conventions](https://github.com/open-telemetry/opentelemetry-ruby)

| | |
|---|---|
| **Version** | 1.36.0 |
| **Authors** | OpenTelemetry Authors |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Semantic Convention definitions for OpenTelemetry

**Dependencies:** opentelemetry-api (~> 1.0)

## [openweathermap](https://github.com/becauseofprog/openweathermap-ruby)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Exybore |
| **License** | MIT |

🌐 Implementation of OpenWeatherMap API.

An implementation to easily fetch the OpenWeatherMap API.

## [optimist](http://manageiq.github.io/optimist/)

| | |
|---|---|
| **Version** | 3.2.1 |
| **Authors** | William Morgan, Keenan Brock, Jason Frey |
| **License** | MIT |

Optimist is a commandline option parser for Ruby that just gets out of your way.

Optimist is a commandline option parser for Ruby that just gets out of your way. One line of code per option is all you need to write. For that, you get a nice automatically-generated help page, robust option parsing, command subcompletion, and sensible defaults for everything you don't specify.

## [options](https://github.com/ahoward/options)

| | |
|---|---|
| **Version** | 2.3.2 |
| **Authors** | Ara T. Howard |
| **License** | same as ruby's |

options

parse options from *args cleanly

## [optparse](https://github.com/ruby/optparse)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Nobu Nakada |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

OptionParser is a class for command-line option analysis.

## [opus-ruby](https://rubygems.org/gems/opus-ruby)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Matthew Perry |
| **License** | MIT |

Ruby FFI wrapper for the OPUS Audio Codec C library for audio encoding

Ruby FFI Gem for the OPUS Audio Codec

**Dependencies:** ffi (>= 0)

## [ore](https://github.com/ruby-ore/ore#readme)

| | |
|---|---|
| **Version** | 0.11.0 |
| **Authors** | Postmodern |
| **License** | MIT |
| **Ruby** | >= 1.9.1 |

Generate perfect Ruby gems

Ore is a fully configurable and extendable Ruby gem generator. With Ore you spend less time editing files, and more time writing code.

**Dependencies:** thor (~> 0.15)

## [ori](http://github.com/dadooda/ori)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Alex Fortuna |

Object-Oriented RI for IRB Console

## [originator](https://github.com/AlchemyCMS/originator)

| | |
|---|---|
| **Version** | 3.1 |
| **Authors** | DeLynn Berry, Thomas von Deyen |
| **License** | MIT |

Adds originator attributes to your ActiveRecord models.

This gem extends ActiveRecord::Base to add automatic updating of created_by and updated_by attributes of your models in much the same way that the ActiveRecord::Timestamp module updates created_(at/on) and updated_(at/on) attributes.

**Dependencies:** actionpack (>= 4.0), activerecord (>= 4.0)

## [orm_adapter](http://github.com/ianwhite/orm_adapter)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Ian White, Jose Valim |
| **License** | MIT |

orm_adapter provides a single point of entry for using basic features of popular ruby ORMs.  Its target audience is gem authors who want to support many ruby ORMs.

Provides a single point of entry for using basic features of ruby ORMs

## [orthoses](https://github.com/ksss/orthoses)

| | |
|---|---|
| **Version** | 1.20.2 |
| **Authors** | ksss |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Framework for Generate RBS

Build RBS by Rack base architecture

**Dependencies:** rbs (~> 3.0)

## [os](http://github.com/rdp/os)

| | |
|---|---|
| **Version** | 1.1.4 |
| **Authors** | rdp, David McCullars |
| **License** | MIT |

Simple and easy way to know if you're on windows or not (reliably), as well as how many bits the OS is, etc.

The OS gem allows for some useful and easy functions, like OS.windows? (=> true or false) OS.bits ( => 32 or 64) etc"

## [ostruct](https://github.com/ruby/ostruct)

| | |
|---|---|
| **Version** | 0.6.3 |
| **Authors** | Marc-Andre Lafortune |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Class to build custom data structures, similar to a Hash.

## [ougai](https://github.com/tilfin/ougai)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Toshimitsu Takahashi |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

JSON logger compatible with node-bunyan or pino is capable of handling structured data easily.

A structured logging system is capable of handling a message, custom data or an exception easily. It has JSON formatters compatible with Bunyan or pino for Node.js and human readable formatter with Amazing Print for console.

**Dependencies:** oj (~> 3.10)

## [overcommit](https://github.com/sds/overcommit)

| | |
|---|---|
| **Version** | 0.68.0 |
| **Authors** | Shane da Silva |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Git hook manager

Utility to install, configure, and extend Git hooks

**Dependencies:** childprocess (>= 0.6.3, < 6), iniparse (~> 1.4), rexml (>= 3.3.9)

## [ox](http://www.ohler.com/ox)

| | |
|---|---|
| **Version** | 2.14.23 |
| **Authors** | Peter Ohler |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A fast XML parser and object serializer.

A fast XML parser and object serializer that uses only standard C lib.  Optimized XML (Ox), as the name implies was written to provide speed optimized XML handling. It was designed to be an alternative to Nokogiri and other Ruby XML parsers for generic XML parsing and as an alternative to Marshal for Object serialization.

**Dependencies:** bigdecimal (>= 3.0)

## [p2p2](https://github.com/takafan/p2p2)

| | |
|---|---|
| **Version** | 0.27.0 |
| **Authors** | takafan |
| **License** | MIT |

p2p

p2p连回家。

## [packable](https://rubygems.org/gems/packable)

| | |
|---|---|
| **Version** | 1.3.18 |
| **Authors** | Marc-André Lafortune |
| **Ruby** | >= 1.8.7 |

Extensive packing and unpacking capabilities

If you need to do read and write binary data, there is of course <Array::pack and String::unpack\n      The packable library makes (un)packing nicer, smarter and more powerful.\n

## [packs-specification](https://github.com/rubyatscale/packs-specification)

| | |
|---|---|
| **Version** | 0.0.11 |
| **Authors** | Gusto Engineers |
| **License** | MIT |
| **Ruby** | >= 3.1 |

The specification for packs in the `rubyatscale` ecosystem.

**Dependencies:** sorbet-runtime (>= 0)

## [packwerk](https://github.com/Shopify/packwerk)

| | |
|---|---|
| **Version** | 3.2.3 |
| **Authors** | Shopify Inc. |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Packages for applications based on the zeitwerk autoloader

Sets package level boundaries between a specified set of ruby constants to minimize cross-boundary referencing and dependency.

**Dependencies:** activesupport (>= 6.0), bundler (>= 0), constant_resolver (>= 0.3), parallel (>= 0), sorbet-runtime (>= 0.5.9914), zeitwerk (>= 2.6.1), ast (>= 0), parser (>= 0), prism (>= 0.25.0), better_html (>= 0)

## [packwerk-extensions](https://github.com/rubyatscale/packwerk-extensions)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Gusto Engineers |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A collection of extensions for packwerk packages.

**Dependencies:** packwerk (>= 2.2.1), railties (>= 6.0.0), sorbet-runtime (>= 0), zeitwerk (>= 0)

## [paco](https://github.com/skryukov/paco)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Svyatoslav Kryukov |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

Parser combinator library

Paco is a parser combinator library.

## [padrino-helpers](http://www.padrinorb.com)

| | |
|---|---|
| **Version** | 0.15.3 |
| **Authors** | Padrino Team, Nathan Esquenazi, Davide D'Agostino, Arthur Chiu |
| **License** | MIT |

Helpers for padrino

Tag helpers, asset helpers, form helpers, form builders and many more helpers for padrino

**Dependencies:** padrino-support (= 0.15.3), tilt (>= 1.4.1, < 3), i18n (>= 0.6.7, < 2)

## [padrino-support](http://www.padrinorb.com)

| | |
|---|---|
| **Version** | 0.15.3 |
| **Authors** | Padrino Team, Nathan Esquenazi, Davide D'Agostino, Arthur Chiu, Igor Bochkariov |
| **License** | MIT |

Support for padrino

A number of support methods and extensions for Padrino framework

## [pagy](https://github.com/ddnexus/pagy)

| | |
|---|---|
| **Version** | 8.6.3 |
| **Authors** | Domizio Demichelis |
| **License** | MIT |
| **Ruby** | >= 3.1 |

The best pagination ruby gem

Agnostic pagination in plain ruby. It does it all. Better.

## [pagy_cursor](https://github.com/Uysim/pagy-cursor)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Uysim |
| **License** | MIT |

cursor-based pagination for pagy

use pagy for cursor-based pagination with rails

**Dependencies:** pagy (>= 6, < 9), activerecord (>= 5)

## [paint](https://github.com/janlelis/paint)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Terminal painter!

Terminal painter with RGB and 256 (fallback) color and terminal effects support. No string extensions! Usage: Paint['string', :red, :bright]

## [pandocomatic](https://heerdebeer.org/Software/markdown/pandocomatic/)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Huub de Beer |
| **License** | GPL-3.0-or-later |
| **Ruby** | >= 3.1.0 |

Automate the use of pandoc

Pandocomatic is a tool to automate using pandoc. With pandocomatic you can express common patterns of using pandoc for generating your documents. Applied to a directory, pandocomatic can act as a static site generator.

**Dependencies:** logger (~> 1.7), optimist (~> 3.2, >= 3.2), paru (~> 1.1, >= 1.5.2)

## [panko](https://github.com/barsoom/panko)

| | |
|---|---|
| **Version** | 0.0.3 |
| **Authors** | Joakim Kolsjö, Henrik Nyh |
| **License** | MIT |

Breadcrumb trails the right way: object-oriented outside the controller.

**Dependencies:** attr_extras (>= 0), breadcrumbs_on_rails (>= 0), i18n (>= 0), activesupport (>= 0)

## [panko_serializer](https://panko.dev)

| | |
|---|---|
| **Version** | 0.8.4 |
| **Authors** | Yosi Attias |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

High Performance JSON Serialization for ActiveRecord & Ruby Objects

**Dependencies:** oj (> 3.11.0, < 4.0.0), activesupport (>= 0)

## [paper_trail](https://github.com/paper-trail-gem/paper_trail)

| | |
|---|---|
| **Version** | 17.0.0 |
| **Authors** | Andy Stewart, Ben Atkins, Jared Beck |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Track changes to your models.

Track changes to your models, for auditing or versioning. See how a model looked at any stage in its lifecycle, revert it to any version, or restore it after it has been destroyed.

**Dependencies:** activerecord (>= 7.1), request_store (~> 1.4)

## [paper_trail-association_tracking](https://github.com/westonganger/paper_trail-association_tracking)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Weston Ganger, Jared Beck, Ben Atkins |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Plugin for the PaperTrail gem to track and reify associations

**Dependencies:** paper_trail (>= 12.0)

## [paper_trail-globalid](https://github.com/ankit1910/paper_trail-globalid)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Ankit |
| **License** | MIT |

An extension to paper_trail, using this you can fetch actual object who was responsible for this change

**Dependencies:** paper_trail (>= 3.0.0), globalid (>= 0)

## [papercraft](http://github.com/digital-fabric/papercraft)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Sharon Rosner |
| **License** | MIT |
| **Ruby** | >= 3.4 |

Papercraft: functional HTML templating for Ruby

**Dependencies:** sirop (~> 1.0.1), kramdown (~> 2.5.1), rouge (~> 4.6.1), kramdown-parser-gfm (~> 1.1.0), erb (~> 5.1.1)

## [parallel](https://github.com/grosser/parallel)

| | |
|---|---|
| **Version** | 1.27.0 |
| **Authors** | Michael Grosser |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Run any kind of code in parallel processes

## [parklife](https://parklife.dev)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Ben Pickles |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Convert a Rack app into a static HTML site.

**Dependencies:** nokogiri (>= 0), rack-test (>= 0), thor (>= 0)

## [parse_packwerk](https://github.com/rubyatscale/parse_packwerk)

| | |
|---|---|
| **Version** | 0.27.0 |
| **Authors** | Gusto Engineers |
| **License** | MIT |
| **Ruby** | >= 2.6 |

A low-dependency gem for parsing and writing packwerk YML files

**Dependencies:** bigdecimal (>= 0), sorbet-runtime (>= 0)

## [parser](https://github.com/whitequark/parser)

| | |
|---|---|
| **Version** | 3.3.10.1 |
| **Authors** | whitequark |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A Ruby parser written in pure Ruby.

**Dependencies:** ast (~> 2.4.1), racc (>= 0)

## [parser_node_ext](https://github.com/synvert-hq/parser_node_ext)

| | |
|---|---|
| **Version** | 1.4.2 |
| **Authors** | Richard Huang |
| **Ruby** | >= 2.6.0 |

extend parser node

extend parser node, add parent and sibling, use meaning properties to get child node

**Dependencies:** parser (>= 0)

## [parslet](http://kschiess.github.io/parslet)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Kaspar Schiess |
| **License** | MIT |

Parser construction library with great error reporting in Ruby.

## [paru](https://heerdebeer.org/Software/markdown/paru/)

| | |
|---|---|
| **Version** | 1.5.2 |
| **Authors** | Huub de Beer |
| **License** | GPL-3.0-or-later |
| **Ruby** | >= 2.6.8 |

Paru is a ruby wrapper around pandoc

Control pandoc with Ruby and write pandoc filters in Ruby

**Dependencies:** csv (~> 3.3)

## [passwordless](https://github.com/mikker/passwordless)

| | |
|---|---|
| **Version** | 1.8.1 |
| **Authors** | Mikkel Malmberg |
| **License** | MIT |

Add authentication to your app without all the ickyness of passwords.

**Dependencies:** rails (>= 5.1.4), bcrypt (>= 3.1.11)

## [pastel](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Terminal strings styling with intuitive and clean API.

**Dependencies:** tty-color (~> 0.5)

## [path](https://github.com/eregon/path)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | eregon |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

The Path manipulation library

Path is a library to easily manage paths and with a lot of extra goodness.

## [path_expander](https://github.com/seattlerb/path_expander)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Ryan Davis |
| **License** | MIT |

PathExpander helps pre-process command-line arguments expanding directories into their constituent files

PathExpander helps pre-process command-line arguments expanding directories into their constituent files. It further helps by providing additional mechanisms to make specifying subsets easier with path subtraction and allowing for command-line arguments to be saved in a file.  NOTE: this is NOT an options processor. It is a path processor (basically everything else besides options). It does provide a mechanism for pre-filtering cmdline options, but not with the intent of actually processing them in PathExpander. Use OptionParser to deal with options either before or after passing ARGV through PathExpander.

## [pathname](https://github.com/ruby/pathname)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Representation of the name of a file or directory on the filesystem

## [pathname-common_prefix](https://gitlab.com/KitaitiMakoto/pathname-common_prefix)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | KITAITI Makoto |

Calculate prefix commont to some pathnames

This file provides `Pathname.common_prefix` and `Pathname#common_prefix` which calculate the common prefix in the passed paths.

## [pathutil](http://github.com/envygeeks/pathutil)

| | |
|---|---|
| **Version** | 0.16.2 |
| **Authors** | Jordon Bedwell |
| **License** | MIT |

Almost like Pathname but just a little less insane.

Like Pathname but a little less insane.

**Dependencies:** forwardable-extended (~> 2.6)

## [patience_diff](http://github.com/watt/ruby_patience_diff)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Andrew Watt |
| **License** | MIT |

A Ruby implementation of the Patience diff algorithm

A Ruby implementation of the Patience diff algorithm.  Patience Diff creates more readable diffs than other algorithms in some cases, particularly when much of the content has changed between the documents being compared. There's a great explanation and example [here][example].  Patience diff was originally written by Bram Cohen and is used in the [Bazaar][bazaar] version control system. This version is loosely based off the Python implementation in Bazaar.  [example]: http://alfedenzo.livejournal.com/170301.html [bazaar]: http://bazaar.canonical.com/

**Dependencies:** optimist (~> 3.0)

## [patron](https://github.com/toland/patron)

| | |
|---|---|
| **Version** | 0.13.4 |
| **Authors** | Aeryn Riley Dowling-Toland |
| **License** | MIT |

Patron HTTP Client

Ruby HTTP client library based on libcurl

## [pdf-core](http://prawnpdf.org/)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Alexander Mankuta, Gregory Brown, Brad Ediger, Daniel Nelson, Jonathan Greenberg, James Healy |
| **License** | Nonstandard, GPL-2.0-only, GPL-3.0-only |
| **Ruby** | >= 2.7 |

Low level PDF generator.

PDF::Core is used by Prawn to render PDF documents. It provides low-level format support.

## [pdf-reader](https://github.com/yob/pdf-reader)

| | |
|---|---|
| **Version** | 2.15.1 |
| **Authors** | James Healy |
| **License** | MIT |
| **Ruby** | >= 2.1 |

A library for accessing the content of PDF files

The PDF::Reader library implements a PDF parser conforming as much as possible to the PDF specification from Adobe

**Dependencies:** Ascii85 (>= 1.0, < 3.0, != 2.0.0), ruby-rc4 (>= 0), hashery (~> 2.0), ttfunk (>= 0), afm (>= 0.2.1, < 2)

## [pdf_ocr](https://github.com/RaviShankarSinghal/ocr_gem)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Ravi Shankar Singhal |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A lightweight Ruby gem for extracting text from images using OCR.

OCR is a Ruby gem that allows you to easily extract text from image files (JPG, PNG, PDF) using Tesseract OCR engine. It provides a simple, intuitive interface for integrating OCR capabilities into your Ruby or Rails applications.

**Dependencies:** pdf-reader (>= 0), mini_magick (>= 0), rtesseract (>= 0)

## [pennyworth](https://alchemists.io/projects/pennyworth)

| | |
|---|---|
| **Version** | 19.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A command line interface for augmented Alfred workflows.

**Dependencies:** cogger (~> 2.0), containable (~> 2.0), core (~> 3.0), etcher (~> 4.0), ghub (~> 1.0), http (~> 5.3), infusible (~> 5.0), ox (~> 2.14), rack (~> 3.1), refinements (~> 14.0), runcom (~> 13.0), sod (~> 2.0), spek (~> 5.0), zeitwerk (~> 2.7)

## [pericope](http://github.com/boblail/pericope)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Bob Lail |

Pericope is a gem for parsing Bible references.

It recognizes common abbreviations and misspellings for names of the books of the Bible and a variety of ways of denoting ranges of chapters and verses. It can parse pericopes singly or out of a block of text. It's useful for comparing two pericopes for intersection and normalizing them into a well-formatted string.

## [pessimize](https://github.com/joonty/pessimize)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Jon Cairns |
| **License** | MIT |

Add the pessimistic constraint operator to all gems in your Gemfile, restricting the maximum update version.

Add the pessimistic constraint operator to all gems in your Gemfile, restricting the maximum update version.  This is for people who work with projects that use bundler, such as rails projects. The pessimistic constraint operator (~>) allows you to specify the maximum version that a gem can be updated, and reduces potential breakages when running `bundle update`. Pessimize automatically retrieves the current versions of your gems, then adds them to your Gemfile (so you don't have to do it by hand).

**Dependencies:** bundler (>= 0), optimist (>= 0)

## [pg](https://github.com/ged/ruby-pg)

| | |
|---|---|
| **Version** | 1.6.3 |
| **Authors** | Michael Granger, Lars Kanis |
| **License** | BSD-2-Clause |
| **Ruby** | >= 3.0, < 4.1.dev |

Pg is the Ruby interface to the PostgreSQL RDBMS

Pg is the Ruby interface to the PostgreSQL RDBMS. It works with PostgreSQL 10 and later.

## [pg-locks-monitor](http://github.com/pawurb/pg-locks-monitor)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | pawurb |
| **License** | MIT |

Observe PostgreSQL database locks obtained by a Rails application.

This gem allows to monitor and notify about PostgreSQL database locks which meet certain criteria. You can report locks which are held for a certain amount of time, or locks which are held by a certain query.

**Dependencies:** rails-pg-extras (>= 0), slack-notifier (>= 0)

## [pg_partition_manager](https://github.com/honeybadger-io/pg_partition_manager)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Benjamin Curtis |
| **License** | MIT |

Manage PostgreSQL table partitions

**Dependencies:** pg (~> 1.0)

## [pg_party](https://github.com/rkrage/pg_party)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | Ryan Krage |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

ActiveRecord PostgreSQL Partitioning

Migrations and model helpers for creating and managing PostgreSQL 10 partitions

**Dependencies:** activerecord (>= 7.2, < 8.2), parallel (~> 1.0)

## [pg_query](https://github.com/pganalyze/pg_query)

| | |
|---|---|
| **Version** | 6.2.2 |
| **Authors** | Lukas Fittl |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.0 |

PostgreSQL query parsing and normalization library

Parses SQL queries using a copy of the PostgreSQL server query parser

**Dependencies:** google-protobuf (>= 3.25.3)

## [pg_search](https://github.com/Casecommons/pg_search)

| | |
|---|---|
| **Version** | 2.3.7 |
| **Authors** | Grant Hutchins, Case Commons, LLC |
| **License** | MIT |
| **Ruby** | >= 3.0 |

PgSearch builds Active Record named scopes that take advantage of PostgreSQL's full text search

**Dependencies:** activerecord (>= 6.1), activesupport (>= 6.1)

## [pg_trunk](https://github.com/nepalez/pg_trunk)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Andrew Kozin |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Empower PostgreSQL migrations in Rails app

Adds methods to ActiveRecord::Migration to create and manage PostgreSQL objects in Rails

**Dependencies:** activerecord (>= 4.0.0), pg (>= 0), railties (>= 4.0.0)

## [pghero](https://github.com/ankane/pghero)

| | |
|---|---|
| **Version** | 3.7.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A performance dashboard for Postgres

**Dependencies:** activerecord (>= 7.1)

## [pgsync](https://github.com/ankane/pgsync)

| | |
|---|---|
| **Version** | 0.8.1 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Sync Postgres data between databases

**Dependencies:** bigdecimal (>= 0), parallel (>= 0), pg (>= 0.18.2), slop (>= 4.10.1), tty-spinner (>= 0)

## [pgvector](https://github.com/pgvector/pgvector-ruby)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.1 |

pgvector support for Ruby

## [phash-rb](http://github.com/khasinski/phash-rb)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Tomasz Ratajczak, Krzysztof Hasiński |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Ruby implementation of pHash library

Ruby implementation of pHash library, uses VIPS for image processing

**Dependencies:** ruby-vips (~> 2.0), matrix (>= 0)

## [phlex](https://www.phlex.fun)

| | |
|---|---|
| **Version** | 2.4.1 |
| **Authors** | Joel Drapper, Will Cosgrove |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Object-oriented views in Ruby.

Build HTML, SVG and CSV views with Ruby classes.

**Dependencies:** zeitwerk (~> 2.7), refract (~> 1.0)

## [phlex-rails](https://www.phlex.fun)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Joel Drapper, Will Cosgrove |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A Phlex adapter for Rails

Object-oriented views in pure Ruby.

**Dependencies:** phlex (~> 2.4.0), railties (>= 7.1, < 9), zeitwerk (~> 2.7)

## [pinecone](https://rubygems.org/gems/pinecone)

| | |
|---|---|
| **Version** | 0.1.71 |
| **Authors** | Scott Carleton |
| **License** | MIT |

Ruby client library for Pinecone Vector DB

Ruby client library which includes index and vector operations to upload embeddings into Pinecone and do similarity searches on them.

**Dependencies:** httparty (~> 0.21.0), dry-struct (~> 1.6.0), dry-validation (~> 1.10.0)

## [pipeable](https://alchemists.io/projects/pipeable)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A domain specific language for building functionally composable steps.

**Dependencies:** containable (~> 2.0), dry-monads (~> 1.9), marameters (~> 5.0), refinements (~> 14.0), zeitwerk (~> 2.7)

## [pkce_challenge](https://github.com/samuelralak/pkce-challenge-ruby)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Samuel Ralak |
| **License** | MIT |

PKCE flow code verifier and code challenge generator

## [pkg-config](https://github.com/ruby-gnome/pkg-config)

| | |
|---|---|
| **Version** | 1.6.5 |
| **Authors** | Sutou Kouhei |
| **License** | LGPLv2+ |

A pkg-config implementation for Ruby

pkg-config can be used in your extconf.rb to properly detect need libraries for compiling Ruby native extensions

## [plat4m](https://github.com/mcorino/plat4m)

| | |
|---|---|
| **Version** | 1.1.8 |
| **Authors** | Martin Corino |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Runtime system detection.

Plat4m is a simple runtime system platform scouting and support library.

## [platform_agent](https://github.com/basecamp/platform_agent)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Parse user agent to deduce the platform.

**Dependencies:** activesupport (>= 5.2.0), useragent (~> 0.16.3)

## [playwright-ruby-client](https://github.com/YusukeIwaki/playwright-ruby-client)

| | |
|---|---|
| **Version** | 1.58.0 |
| **Authors** | YusukeIwaki |
| **License** | MIT |
| **Ruby** | >= 2.4 |

The Ruby binding of playwright driver 1.58.0

**Dependencies:** base64 (>= 0), concurrent-ruby (>= 1.1.6), mime-types (>= 3.0)

## [plist](https://github.com/patsplat/plist)

| | |
|---|---|
| **Version** | 3.7.2 |
| **Authors** | Ben Bleything, Patrick May |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

All-purpose Property List manipulation library

Plist is a library to manipulate Property List files, also known as plists. It can parse plist files into native Ruby data structures as well as generating new plist files from your Ruby objects.

## [pmap](https://github.com/bruceadams/pmap)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Bruce Adams, Jake Goulding, David Biehl |
| **License** | Apache-2.0 |

Add parallel methods into Enumerable: pmap and peach

## [pocketflow](https://github.com/jonmagic/PocketFlow-Ruby)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Jonathan Hoyt |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

pocketflow.rb is a Ruby port of the original Python version - a minimalist LLM framework.

Pocket Flow: A minimalist LLM framework. Let Agents build Agents!

## [pocketrb](https://github.com/mensfeld/pocketrb)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Maciej Mensfeld |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Pocket-sized Ruby AI agent framework with multi-LLM support

Pocketrb is a Ruby AI agent framework featuring async message bus architecture, multi-LLM support (Claude, OpenRouter, RubyLLM), multi-channel messaging (CLI, Telegram, WhatsApp), planning system, context compaction, and simple JSON-based memory with keyword matching.

**Dependencies:** anthropic (~> 0.3), async (~> 2.0), faraday (~> 2.0), faraday-follow_redirects (~> 0.3), json (~> 2.7), pastel (~> 0.8), playwright-ruby-client (~> 1.58), ruby_llm (~> 1.0), telegram-bot-ruby (~> 2.0), thor (~> 1.3), tty-markdown (~> 0.7), tty-prompt (~> 0.23), yaml (~> 0.3), zeitwerk (~> 2.6)

## [podcast-buddy](https://github.com/codenamev/podcast-buddy)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Valentino Stoll |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A simple Ruby command-line tool for dropping in an AI buddy to your podcast.

**Dependencies:** async (>= 0), async-http-faraday (>= 0), rainbow (>= 0)

## [polyglot](http://github.com/cjheath/polyglot)

| | |
|---|---|
| **Version** | 0.3.5 |
| **Authors** | Clifford Heath |
| **License** | MIT |

Augment 'require' to load non-Ruby file types

The Polyglot library allows a Ruby module to register a loader for the file type associated with a filename extension, and it augments 'require' to find and load matching files.

## [postgresql_cursor](http://github.com/afair/postgresql_cursor)

| | |
|---|---|
| **Version** | 0.6.9 |
| **Authors** | Allen Fair |
| **License** | MIT |

ActiveRecord PostgreSQL Adapter extension for using a cursor to return a large result set

PostgreSQL Cursor is an extension to the ActiveRecord PostgreSQLAdapter for very large result sets.  It provides a cursor open/fetch/close interface to access data without loading all rows into memory, and instead loads the result rows in 'chunks' (default of 1_000 rows), buffers them, and returns the rows one at a time.

**Dependencies:** activerecord (>= 6.0)

## [power_assert](https://github.com/ruby/power_assert)

| | |
|---|---|
| **Version** | 3.0.1 |
| **Authors** | Kazuki Tsujimoto |
| **License** | BSD-2-Clause, Ruby |

Power Assert for Ruby

Power Assert shows each value of variables and method calls in the expression. It is useful for testing, providing which value wasn't correct when the condition is not satisfied.

## [pp](https://github.com/ruby/pp)

| | |
|---|---|
| **Version** | 0.6.3 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Provides a PrettyPrinter for Ruby objects

**Dependencies:** prettyprint (>= 0)

## [pp_sql](https://github.com/kvokka/pp_sql)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Kvokka |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Beautify SQL output of ActiveRecord#to_sql

Helps to save your eyes, when reading hardcore SQL requests in console

**Dependencies:** activerecord (>= 0), anbt-sql-formatter (~> 0.1.0)

## [pragmater](https://alchemists.io/projects/pragmater)

| | |
|---|---|
| **Version** | 17.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A command line interface for managing pragma comments.

**Dependencies:** cogger (~> 2.0), containable (~> 2.0), dry-schema (~> 1.15), etcher (~> 4.0), infusible (~> 5.0), refinements (~> 14.0), runcom (~> 13.0), sod (~> 2.0), spek (~> 5.0), zeitwerk (~> 2.7)

## [pragmatic_segmenter](https://github.com/diasks2/pragmatic_segmenter)

| | |
|---|---|
| **Version** | 0.3.24 |
| **Authors** | Kevin S. Dias |
| **License** | MIT |

A rule-based sentence boundary detection gem that works out-of-the-box across many languages

Pragmatic Segmenter is a sentence segmentation tool for Ruby. It allows you to split a text into an array of sentences. This gem provides 2 main benefits over other segmentation gems - 1) It works well even with ill-formatted text 2) It works for multiple languages

## [prawn](http://prawnpdf.org/)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Alexander Mankuta, Gregory Brown, Brad Ediger, Daniel Nelson, Jonathan Greenberg, James Healy |
| **License** | Nonstandard, GPL-2.0-only, GPL-3.0-only |
| **Ruby** | >= 2.7 |

A fast and nimble PDF generator for Ruby

Prawn is a fast, tiny, and nimble PDF generator for Ruby

**Dependencies:** matrix (~> 0.4), pdf-core (~> 0.10.0), ttfunk (~> 1.8)

## [prawn-table](https://github.com/prawnpdf/prawn-table)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Gregory Brown, Brad Ediger, Daniel Nelson, Jonathan Greenberg, James Healy, Hartwig Brandl |
| **License** | RUBY, GPL-2, GPL-3 |
| **Ruby** | >= 1.9.3 |

Provides tables for PrawnPDF

Prawn::Table provides tables for the Prawn PDF toolkit

**Dependencies:** prawn (>= 1.3.0, < 3.0.0)

## [predicate](http://github.com/enspirit/predicate)

| | |
|---|---|
| **Version** | 2.9.0 |
| **Authors** | Bernard Lambeau |
| **License** | MIT |

Predicate provides a simple class and processors to encode and manipulate (tuple) predicates

**Dependencies:** sexpr (~> 1.1), minitest (>= 5.0)

## [premailer](https://github.com/premailer/premailer)

| | |
|---|---|
| **Version** | 1.27.0 |
| **Authors** | Alex Dunae |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.0 |

Preflight for HTML e-mail.

Improve the rendering of HTML emails by making CSS inline, converting links and warning about unsupported code.

**Dependencies:** css_parser (>= 1.19.0), htmlentities (>= 4.0.0), addressable (>= 0)

## [premailer-rails](https://github.com/fphilipe/premailer-rails)

| | |
|---|---|
| **Version** | 1.12.0 |
| **Authors** | Philipe Fatio |
| **License** | MIT |

Easily create styled HTML emails in Rails.

This gem brings you the power of the premailer gem to Rails without any configuration needs. Create HTML emails, include a CSS file as you do in a normal HTML document and premailer will inline the included CSS.

**Dependencies:** premailer (~> 1.7, >= 1.7.9), actionmailer (>= 3), net-smtp (>= 0)

## [prettier_print](https://github.com/ruby-syntax-tree/prettier_print)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Kevin Newton |
| **License** | MIT |

A drop-in replacement for the prettyprint gem with more functionality.

## [pretty_please](https://github.com/joeldrapper/pretty_please)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Joel Drapper, Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Print Ruby objects as Ruby

**Dependencies:** dispersion (~> 0.2)

## [prettyprint](https://github.com/ruby/prettyprint)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Implements a pretty printing algorithm for readable structure.

## [prime](https://github.com/ruby/prime)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Marc-Andre Lafortune |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Prime numbers and factorization library.

**Dependencies:** singleton (>= 0), forwardable (>= 0)

## [prism](https://github.com/ruby/prism)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Shopify |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Prism Ruby parser

## [prism-merge](https://github.com/kettle-rb/prism-merge)

| | |
|---|---|
| **Version** | 1.1.6 |
| **Authors** | Peter H. Boling |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

☯️ Intelligently merge two versions of a Ruby file using Prism AST analysis, useful in templating

☯️ Intelligently merge two versions of a Ruby file using Prism AST analysis, similar to a smart 'git merge' specifically designed for Ruby code.

**Dependencies:** prism (~> 1.6), version_gem (~> 1.1, >= 1.1.9)

## [prism_ext](https://github.com/synvert-hq/prism_ext)

| | |
|---|---|
| **Version** | 0.4.2 |
| **Authors** | Richard Huang |
| **Ruby** | >= 2.7.0 |

extend ruby prism

**Dependencies:** prism (>= 0)

## [process-metrics](https://github.com/socketry/process-metrics)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Samuel Williams, Adam Daniels |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provide detailed OS-specific process metrics.

**Dependencies:** console (~> 1.8), json (~> 2), samovar (~> 2.1)

## [process_executer](https://github.com/main-branch/process_executer)

| | |
|---|---|
| **Version** | 4.0.2 |
| **Authors** | James Couball |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Enhanced subprocess execution with timeouts, output capture, and flexible redirection

ProcessExecuter provides a simple API for running commands in a subprocess, with options for capturing output, handling timeouts, logging, and more. It also provides the MonitoredPipe class which expands the output redirection capabilities of Ruby's Process.spawn.

**Dependencies:** track_open_instances (~> 0.1)

## [progress_bar](http://github.com/paul/progress_bar)

| | |
|---|---|
| **Version** | 1.3.4 |
| **Authors** | Paul Sadauskas |
| **License** | WTFPL |
| **Ruby** | >= 2.4.0 |

Simple Progress Bar for output to a terminal

Give people feedback about long-running tasks without overloading them with information: Use a progress bar, like Curl or Wget!

**Dependencies:** highline (>= 1.6), options (~> 2.3.0)

## [progressbar](https://github.com/jfelchner/ruby-progressbar)

| | |
|---|---|
| **Version** | 1.13.0 |
| **Authors** | thekompanee, jfelchner |
| **License** | MIT |

Ruby/ProgressBar is a flexible text progress bar library for Ruby.

Ruby/ProgressBar is an extremely flexible text progress bar library for Ruby. The output can be customized with a flexible formatting system including: percentage, bars of various formats, elapsed time and estimated time remaining.

## [prometheus-client](https://github.com/prometheus/client_ruby)

| | |
|---|---|
| **Version** | 4.2.5 |
| **Authors** | Ben Kochie, Chris Sinjakli, Daniel Magliola |
| **License** | Apache-2.0 |

A suite of instrumentation metric primitivesthat can be exposed through a web services interface.

**Dependencies:** base64 (>= 0)

## [prompt_manager](https://github.com/MadBomber/prompt_manager)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Parse YAML metadata from markdown prompts with shell expansion and ERB rendering

PM (PromptManager) parses YAML metadata from markdown strings or files. It expands shell references, extracts metadata and content, and renders ERB templates on demand.

**Dependencies:** ostruct (>= 0)

## [prompt_objects](https://github.com/works-on-your-machine/prompt_objects)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Scott Werner |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

LLM-backed entities as first-class autonomous objects

A framework where markdown files with LLM-backed behavior act as first-class autonomous entities. Features inter-object communication and environment management.

**Dependencies:** thor (~> 1.3), ruby_llm (~> 1.2), front_matter_parser (~> 1.0), sqlite3 (~> 2.0), falcon (~> 0.50), async-websocket (~> 0.28), rack (~> 3.0), listen (~> 3.9), mcp (~> 0.4)

## [prompts](https://github.com/fractaledmind/prompts)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Stephen Margheim |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Beautiful and user-friendly forms for your command-line Ruby applications.

Inspired by the Laravel Prompts project

**Dependencies:** unicode-display_width (>= 0), unicode-emoji (>= 0), reline (>= 0), fmt (>= 0.3.0), rainbow (>= 0)

## [prop_initializer](https://github.com/avo-hq/prop_initializer)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Paul Bob |
| **License** | MIT |

A flexible property initializer for Ruby classes inspired by the Literal gem.

PropInitializer provides an easy way to define properties for Ruby classes with options for defaults and customization. It simplifies the Literal gem's functionality by removing strict type requirements and adapting the initializer process for flexibility.

**Dependencies:** zeitwerk (>= 2.6.18)

## [props_template](https://github.com/thoughtbot/props_template/)

| | |
|---|---|
| **Version** | 0.38.0 |
| **Authors** | Johny Ho |
| **License** | MIT |
| **Ruby** | >= 2.5 |

A fast JSON builder

PropsTemplate is a direct-to-Oj, JBuilder-like DSL for building JSON. It has support for Russian-Doll caching, layouts, and can be queried by giving the root a key path.

**Dependencies:** activesupport (>= 7.0, < 9.0), actionview (>= 7.0, < 9.0), oj (~> 3.9)

## [propshaft](https://github.com/rails/propshaft)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Deliver assets for Rails.

**Dependencies:** actionpack (>= 7.0.0), activesupport (>= 7.0.0), rack (>= 0)

## [prosopite](https://github.com/charkost/prosopite)

| | |
|---|---|
| **Version** | 2.1.2 |
| **Authors** | Mpampis Kostas |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.4.0 |

N+1 auto-detection for Rails with zero false positives / false negatives

## [protocol](https://github.com/flori/protocol)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Florian Frank |
| **License** | GPL-2 |

Method Protocols for Ruby Classes

This library offers an implementation of protocols against which you can check the conformity of your classes or instances of your classes. They are a bit like Java Interfaces, but as mixin modules they can also contain already implemented methods. Additionaly you can define preconditions/postconditions for methods specified in a protocol.

**Dependencies:** ruby_parser (~> 3.0)

## [protocol-hpack](https://github.com/socketry/http-hpack)

| | |
|---|---|
| **Version** | 1.5.1 |
| **Authors** | Samuel Williams, Ilya Grigorik, Tamir Duberstein, Nathan Froyd, Kaoru Maeda, Tiago Cardoso, Byron Formwalt, Cyril Roelandt, Daniel Morrison, Felix Yan, George Ulmer, Jingyi Chen, Justin Mazzocchi, Kenichi Nakamura, Kien Nguyen Trung, Maruth Goyal, Olle Jonsson |
| **License** | MIT |
| **Ruby** | >= 3.1 |

A compresssor and decompressor for HTTP/2's HPACK format.

## [protocol-http](https://github.com/socketry/protocol-http)

| | |
|---|---|
| **Version** | 0.59.0 |
| **Authors** | Samuel Williams, Thomas Morgan, Bruno Sutic, Herrick Fang, William T. Nelson, Bryan Powell, Dan Olson, Earlopain, Genki Takiuchi, Marcelo Junior, Olle Jonsson, Yuta Iwama |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provides abstractions to handle HTTP protocols.

## [protocol-http1](https://github.com/socketry/protocol-http1)

| | |
|---|---|
| **Version** | 0.37.0 |
| **Authors** | Samuel Williams, Thomas Morgan, Anton Zhuravsky, Brian Morearty, Bruno Sutic, Olle Jonsson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A low level implementation of the HTTP/1 protocol.

**Dependencies:** protocol-http (~> 0.58)

## [protocol-http2](https://github.com/socketry/protocol-http2)

| | |
|---|---|
| **Version** | 0.24.0 |
| **Authors** | Samuel Williams, Yuta Iwama, Adam Petro, Marco Concetto Rudilosso, Olle Jonsson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A low level implementation of the HTTP/2 protocol.

**Dependencies:** protocol-hpack (~> 1.4), protocol-http (~> 0.47)

## [protocol-rack](https://github.com/socketry/protocol-rack)

| | |
|---|---|
| **Version** | 0.21.1 |
| **Authors** | Samuel Williams, Francisco Mejia, Genki Takiuchi |
| **License** | MIT |
| **Ruby** | >= 3.2 |

An implementation of the Rack protocol/specification.

**Dependencies:** io-stream (>= 0.10), protocol-http (~> 0.58), rack (>= 1.0)

## [protocol-redis](https://github.com/socketry/protocol-redis)

| | |
|---|---|
| **Version** | 0.13.0 |
| **Authors** | Samuel Williams, Dimitry Chopey, Nick Burwell, David Ortiz, Nakul Warrier, Troex Nevelin, Daniel Evans, Olle Jonsson, Salim Semaoune |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A transport agnostic RESP protocol client/server.

## [protocol-url](https://github.com/socketry/protocol-url)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Provides abstractions for working with URLs.

## [protocol-websocket](https://github.com/socketry/protocol-websocket)

| | |
|---|---|
| **Version** | 0.20.2 |
| **Authors** | Samuel Williams, Aurora Nockert, Soumya, Olle Jonsson, Taleh Zaliyev, William T. Nelson |
| **License** | MIT |
| **Ruby** | >= 3.1 |

A low level implementation of the WebSocket protocol.

**Dependencies:** protocol-http (~> 0.2)

## [prreview](https://github.com/evmorov/prreview)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Evgenii Morozov, Iurii Alekseev, Quint |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A CLI tool that formats GitHub PRs for LLM code reviews.

PrReview collects PR data from GitHub (description, commits, comments, linked issues, and code changes) and formats it as XML. Paste this XML into any LLM like ChatGPT or Claude to get helpful code reviews.

**Dependencies:** base64 (~> 0.2), clipboard (~> 2.0), faraday-retry (~> 2.3), nokogiri (~> 1.18), octokit (~> 10.0)

## [pry](http://pry.github.io)

| | |
|---|---|
| **Version** | 0.14.2 |
| **Authors** | John Mair (banisterfiend), Conrad Irwin, Ryan Fitzgerald, Kyrylo Silin |
| **License** | MIT |
| **Ruby** | >= 2.0 |

A runtime developer console and IRB alternative with powerful introspection capabilities.

Pry is a runtime developer console and IRB alternative with powerful introspection capabilities. Pry aims to be more than an IRB replacement. It is an attempt to bring REPL driven programming to the Ruby language.

**Dependencies:** coderay (~> 1.1), method_source (~> 1.0)

## [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug)

| | |
|---|---|
| **Version** | 3.11.0 |
| **Authors** | David Rodríguez, Gopal Patel |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Fast debugging with Pry.

Combine 'pry' with 'byebug'. Adds 'step', 'next', 'finish', 'continue' and 'break' commands to control execution.

**Dependencies:** byebug (~> 12.0), pry (>= 0.13, < 0.16)

## [pry-rails](https://github.com/rweng/pry-rails)

| | |
|---|---|
| **Version** | 0.3.11 |
| **Authors** | Robin Wenglewski |
| **License** | MIT |
| **Ruby** | >= 1.9.1 |

Use Pry as your rails console

**Dependencies:** pry (>= 0.13.0)

## [pstore](https://github.com/ruby/pstore)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |

Transactional File Storage for Ruby Objects

## [psych](https://github.com/ruby/psych)

| | |
|---|---|
| **Version** | 5.3.1 |
| **Authors** | Aaron Patterson, SHIBATA Hiroshi, Charles Oliver Nutter |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Psych is a YAML parser and emitter

Psych is a YAML parser and emitter. Psych leverages libyaml[https://pyyaml.org/wiki/LibYAML] for its YAML parsing and emitting capabilities. In addition to wrapping libyaml, Psych also knows how to serialize and de-serialize most Ruby objects to and from the YAML format.

**Dependencies:** stringio (>= 0), date (>= 0)

## [psyllium](https://github.com/eestrada/psyllium)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Ethan Estrada |
| **License** | 0BSD |
| **Ruby** | >= 3.3.0 |

A Ruby gem making it easier to use Fibers.

## [public_suffix](https://simonecarletti.com/code/publicsuffix-ruby)

| | |
|---|---|
| **Version** | 4.0.7 |
| **Authors** | Simone Carletti |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Domain name parser based on the Public Suffix List.

PublicSuffix can parse and decompose a domain name into top level domain, domain and subdomains.

## [puma](https://puma.io)

| | |
|---|---|
| **Version** | 6.6.1 |
| **Authors** | Evan Phoenix |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.4 |

A Ruby/Rack web server built for parallelism.

Puma is a simple, fast, multi-threaded, and highly parallel HTTP 1.1 server for Ruby/Rack applications. Puma is intended for use in both development and production environments. It's great for highly parallel Ruby implementations such as JRuby and TruffleRuby as well as as providing process worker support to support CRuby well.

**Dependencies:** nio4r (~> 2.0)

## [pundit](https://github.com/varvet/pundit)

| | |
|---|---|
| **Version** | 2.5.2 |
| **Authors** | Jonas Nicklas, Varvet AB |
| **License** | MIT |

OO authorization for Rails

Object oriented authorization for Rails applications

**Dependencies:** activesupport (>= 3.0.0)

## [pycall](https://github.com/mrkn/pycall)

| | |
|---|---|
| **Version** | 1.5.2 |
| **Authors** | Kenta Murata |
| **License** | MIT |

pycall

## [query_count](https://github.com/rubysamurai/query_count)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Dmitriy Tarasov |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

SQL queries counter for Rails apps

**Dependencies:** activerecord (>= 4.2), railties (>= 4.2)

## [raabro](https://github.com/floraison/raabro)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | John Mettraux |
| **License** | MIT |

a very dumb PEG parser library

A very dumb PEG parser library, with a horrible interface.

## [racc](https://github.com/ruby/racc)

| | |
|---|---|
| **Version** | 1.8.1 |
| **Authors** | Minero Aoki, Aaron Patterson |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5 |

Racc is an LALR(1) parser generator

Racc is an LALR(1) parser generator. It is written in Ruby itself, and generates Ruby program.  NOTE: Ruby 1.8.x comes with Racc runtime module.  You can run your parsers generated by racc 1.4.x out of the box.

## [rack](https://github.com/rack/rack)

| | |
|---|---|
| **Version** | 2.2.21 |
| **Authors** | Leah Neukirchen |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

A modular Ruby webserver interface.

Rack provides a minimal, modular and adaptable interface for developing web applications in Ruby. By wrapping HTTP requests and responses in the simplest way possible, it unifies and distills the API for web servers, web frameworks, and software in between (the so-called middleware) into a single method call.

## [rack-attack](https://github.com/rack/rack-attack)

| | |
|---|---|
| **Version** | 6.8.0 |
| **Authors** | Aaron Suggs |
| **License** | MIT |
| **Ruby** | >= 2.4 |

Block & throttle abusive requests

A rack middleware for throttling and blocking abusive requests

**Dependencies:** rack (>= 1.0, < 4)

## [rack-cache](https://github.com/rack/rack-cache)

| | |
|---|---|
| **Version** | 1.17.0 |
| **Authors** | Ryan Tomayko |
| **License** | MIT |
| **Ruby** | >= 2.7.7 |

HTTP Caching for Rack

Rack::Cache is suitable as a quick drop-in component to enable HTTP caching for Rack-based applications that produce freshness (expires, cache-control) and/or validation (last-modified, etag) information.

**Dependencies:** rack (>= 0.4)

## [rack-livereload](https://github.com/onesupercoder/rack-livereload)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | John Bintz |
| **License** | MIT |

Insert LiveReload into your app easily as Rack middleware

**Dependencies:** rack (>= 3.0, < 3.2)

## [rack-mini-profiler](https://miniprofiler.com)

| | |
|---|---|
| **Version** | 4.0.1 |
| **Authors** | Sam Saffron, Robin Ward, Aleks Totic |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Profiles loading speed for rack applications.

Profiling toolkit for Rack applications with Rails integration. Client Side profiling, DB profiling and Server profiling.

**Dependencies:** rack (>= 1.2.0)

## [rack-oauth2](https://github.com/nov/rack-oauth2)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | nov matake |
| **License** | MIT |

OAuth 2.0 Server & Client Library - Both Bearer token type are supported

OAuth 2.0 Server & Client Library. Both Bearer token type are supported.

**Dependencies:** rack (>= 2.1.0), faraday (~> 2.0), faraday-follow_redirects (>= 0), activesupport (>= 0), attr_required (>= 0), json-jwt (>= 1.11.0)

## [rack-pjax](https://github.com/eval/rack-pjax)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Gert Goet |
| **License** | MIT |

Serve pjax responses through rack middleware

**Dependencies:** rack (>= 1.1), nokogiri (~> 1.5)

## [rack-protection](https://sinatrarb.com/protection/)

| | |
|---|---|
| **Version** | 4.2.1 |
| **Authors** | https://github.com/sinatra/sinatra/graphs/contributors |
| **License** | MIT |
| **Ruby** | >= 2.7.8 |

Protect against typical web attacks, works with all Rack apps, including Rails.

Protect against typical web attacks, works with all Rack apps, including Rails

**Dependencies:** base64 (>= 0.1.0), logger (>= 1.6.0), rack (>= 3.0.0, < 4)

## [rack-proxy](https://github.com/ncr/rack-proxy)

| | |
|---|---|
| **Version** | 0.7.7 |
| **Authors** | Jacek Becela |
| **License** | MIT |
| **Ruby** | >= 2.6 |

A request/response rewriting HTTP proxy. A Rack app.

A Rack app that provides request/response rewriting proxy capabilities with streaming.

**Dependencies:** rack (>= 0)

## [rack-session](https://github.com/rack/rack-session)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Samuel Williams, Jeremy Evans, Jon Dufresne, Philip Arndt |
| **License** | MIT |
| **Ruby** | >= 2.5 |

A session implementation for Rack.

**Dependencies:** base64 (>= 0.1.0), rack (>= 3.0.0)

## [rack-ssl](https://github.com/josh/rack-ssl)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Joshua Peek |
| **License** | MIT |

Force SSL/TLS in your app.

Rack middleware to force SSL/TLS.

**Dependencies:** rack (>= 0)

## [rack-test](https://github.com/rack/rack-test)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Jeremy Evans, Bryan Helmkamp |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Simple testing API built on Rack

Rack::Test is a small, simple testing API for Rack apps. It can be used on its own or as a reusable starting point for Web frameworks and testing libraries to build on.

**Dependencies:** rack (>= 1.3)

## [rackup](https://github.com/rack/rackup)

| | |
|---|---|
| **Version** | 2.3.1 |
| **Authors** | Samuel Williams, James Tucker, Leah Neukirchen, Jeremy Evans, Joshua Peek, Megan Batty, Rafael França, Anurag Priyam, Max Cantor, Michael Fellinger, Sophie Deziel, Yoshiyuki Hirano, Aaron Patterson, Jean Boussier, Katsuhiko Yoshida, Konstantin Haase, Krzysztof Rybka, Martin Hrdlicka, Nick LaMuro, Aaron Pfeifer, Akira Matsuda, Andrew Bortz, Andrew Hoglund, Bas Vodde, Blake Mizerany, Carl Lerche, David Celis, Dillon Welch, Genki Takiuchi, Geremia Taglialatela, Hal Brodigan, Hrvoje Šimić, Igor Bochkariov, Jeremy Kemper, Joe Fiorini, John Barnette, John Sumsion, Julik Tarkhanov, Kang Sheng, Kazuya Hotta, Lenny Marks, Loren Segal, Marc-André Cournoyer, Misaki Shioi, Olle Jonsson, Peter Wilmott, Petrik de Heus, Richard Schneeman, Ryunosuke Sato, Sean McGivern, Stephen Paul Weber, Tadashi Saito, Tim Moore, Timur Batyrshin, Trevor Wennblom, Tsutomu Kuroda, Uchio Kondo, Wyatt Pan, Yehuda Katz, Zachary Scott |
| **License** | MIT |
| **Ruby** | >= 2.5 |

A general server command for Rack applications.

**Dependencies:** rack (>= 3)

## [ragdoll](https://github.com/MadBomber/ragdoll)

| | |
|---|---|
| **Version** | 0.1.12 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Multi-Modal Retrieval Augmented Generation

Under development.  Contributors welcome.

**Dependencies:** activerecord (>= 0), activejob (>= 0), debug_me (>= 0), docx (>= 0), neighbor (>= 0), opensearch-ruby (>= 0), pdf-reader (>= 0), pg (>= 0), pgvector (>= 0), rmagick (>= 0), ruby-progressbar (>= 0), ruby_llm (>= 0), rubyzip (>= 0), searchkick (>= 0), shrine (>= 0)

## [ragdoll-cli](https://github.com/MadBomber/ragdoll-cli)

| | |
|---|---|
| **Version** | 0.1.12 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Unified Text-Based RAG CLI for Cross-Modal Search

Command-line interface for Ragdoll's unified text-based RAG system. Converts all media types (images, audio, documents) to searchable text for powerful cross-modal search capabilities. Under development. Contributors welcome.

**Dependencies:** ragdoll (>= 0.1.12), ruby-progressbar (>= 0), thor (>= 0)

## [ragdoll-rails](https://github.com/MadBomber/ragdoll-rails)

| | |
|---|---|
| **Version** | 0.1.12 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Rails engine for Ragdoll unified text-based RAG system

Rails engine providing ActiveRecord integration, background jobs, and UI components for Ragdoll's unified text-based RAG system. Converts all media types to searchable text for powerful cross-modal search capabilities.

**Dependencies:** ragdoll (>= 0), rails (>= 8.0.2), actioncable (>= 8.0.2), sidekiq (>= 0), view_component (>= 2.0)

## [raif](https://github.com/cultivatelabs/raif)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Ben Roesch, Brian Leslie |
| **License** | MIT |

Raif (Ruby AI Framework) is a Rails engine that helps you add AI-powered features to your Rails apps, such as tasks, conversations, and agents.

Raif (Ruby AI Framework) is a Rails engine that helps you add AI-powered features to your Rails apps, such as tasks, conversations, and agents. It supports for multiple LLM providers including OpenAI, Anthropic Claude, and AWS Bedrock.

**Dependencies:** aws-sdk-bedrockruntime (>= 0), event_stream_parser (>= 1.0), faraday (>= 2.0), json-schema (>= 5.0), loofah (>= 2.21), pagy (< 10.0), rails (>= 7.1), reverse_markdown (>= 2.0), turbo-rails (>= 2.0)

## [rails](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Full-stack web application framework.

Ruby on Rails is a full-stack web framework optimized for programmer happiness and sustainable productivity. It encourages beautiful code by favoring convention over configuration.

**Dependencies:** activesupport (= 7.2.3), actionpack (= 7.2.3), actionview (= 7.2.3), activemodel (= 7.2.3), activerecord (= 7.2.3), actionmailer (= 7.2.3), activejob (= 7.2.3), actioncable (= 7.2.3), activestorage (= 7.2.3), actionmailbox (= 7.2.3), actiontext (= 7.2.3), railties (= 7.2.3), bundler (>= 1.15.0)

## [rails-data-migrations](https://github.com/OffgridElectric/rails-data-migrations)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Sergey Glukhov |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Run your data migration tasks in a db:migrate-like manner

**Dependencies:** rails (>= 4.0.0)

## [rails-deprecated_sanitizer](https://github.com/rails/rails-deprecated_sanitizer)

| | |
|---|---|
| **Version** | 1.0.4 |
| **Authors** | Kasper Timm Hansen |
| **License** | MIT |

Deprecated sanitizer API extracted from Action View.

**Dependencies:** activesupport (>= 4.2.0.alpha)

## [rails-diff](https://github.com/matheusrich/rails-diff)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Matheus Richard |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Compare Rails-generated files with the ones in your repository

rails-diff helps you compare files generated by Rails (like Dockerfile, .gitignore, etc) with the ones in your repository, making it easier to keep track of changes and updates.

**Dependencies:** rails (>= 7.0), diffy (~> 3.4), thor (~> 1.0)

## [rails-dom-testing](https://github.com/rails/rails-dom-testing)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Rafael Mendonça França, Kasper Timm Hansen |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Dom and Selector assertions for Rails applications

This gem can compare doms and assert certain elements exists in doms using Nokogiri.

**Dependencies:** activesupport (>= 5.0.0), minitest (>= 0), nokogiri (>= 1.6)

## [rails-erd](https://github.com/voormedia/rails-erd)

| | |
|---|---|
| **Version** | 1.7.2 |
| **Authors** | Rolf Timmermans, Kerri Miller |
| **License** | MIT |
| **Ruby** | >= 2.2 |

Entity-relationship diagram for your Rails models.

Automatically generate an entity-relationship diagram (ERD) for your Rails models.

**Dependencies:** activerecord (>= 4.2), activesupport (>= 4.2), ruby-graphviz (~> 1.2), choice (~> 0.2.0)

## [rails-graphql](https://github.com/virtualshield/rails-graphql)

| | |
|---|---|
| **Version** | 1.0.6 |
| **Authors** | Carlos Silva |
| **License** | MIT |
| **Ruby** | >= 2.6.3 |

GraphQL meets RoR with the most Ruby-like DSL

A Fresh new GraphQL server for Rails applications, with a focus on natural and Ruby-like DSL

**Dependencies:** rails (>= 6.0)

## [rails-html-sanitizer](https://github.com/rails/rails-html-sanitizer)

| | |
|---|---|
| **Version** | 1.6.2 |
| **Authors** | Rafael Mendonça França, Kasper Timm Hansen, Mike Dalessio |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

This gem is responsible to sanitize HTML fragments in Rails applications.

HTML sanitization for Rails applications

**Dependencies:** loofah (~> 2.21), nokogiri (>= 1.15.7, != 1.16.0, != 1.16.0.rc1, != 1.16.1, != 1.16.2, != 1.16.3, != 1.16.4, != 1.16.5, != 1.16.6, != 1.16.7)

## [rails-mcp-server](https://github.com/maquina-app/rails-mcp-server)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Mario Alberto Chávez Cárdenas |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

MCP server for Rails projects

A Ruby implementation of Model Context Protocol server for Rails projects

**Dependencies:** activesupport (>= 7.0), addressable (~> 2.8), fast-mcp (~> 1.6.0), rack (~> 3.2.0), puma (~> 7.1.0), logger (~> 1.7.0)

## [rails-pg-extras](http://github.com/pawurb/rails-pg-extras)

| | |
|---|---|
| **Version** | 5.6.16 |
| **Authors** | pawurb |
| **License** | MIT |

Rails PostgreSQL performance database insights

Rails port of Heroku PG Extras. The goal of this project is to provide a powerful insights into PostgreSQL database for Ruby on Rails apps that are not using the default Heroku PostgreSQL plugin.

**Dependencies:** ruby-pg-extras (= 5.6.16), railties (>= 0), actionpack (>= 0), activerecord (>= 0)

## [rails-pg-extras-mcp](http://github.com/pawurb/rails-pg-extras-mcp)

| | |
|---|---|
| **Version** | 0.2.6 |
| **Authors** | pawurb |
| **License** | MIT |

MCP interface for rails-pg-extras

MCP interface for rails-pg-extras. It enables LLMs to analyze the PostgreSQL metadata and performance metrics.

**Dependencies:** rails-pg-extras (~> 5.6.12), rails (>= 0), fast-mcp (>= 0), pg_query (>= 0)

## [rails_admin](https://github.com/railsadminteam/rails_admin)

| | |
|---|---|
| **Version** | 3.3.0 |
| **Authors** | Erik Michaels-Ober, Bogdan Gaza, Petteri Kaapa, Benoit Benezech, Mitsuhiro Shibuya |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Admin for Rails

RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data.

**Dependencies:** activemodel-serializers-xml (>= 1.0), csv (>= 0), kaminari (>= 0.14, < 2.0), nested_form (~> 0.3), rails (>= 6.0, < 9), turbo-rails (>= 1.0, < 3)

## [rails_ai](https://github.com/DanielAmah/rails_ai)

| | |
|---|---|
| **Version** | 0.2.8 |
| **Authors** | Daniel Amah |
| **License** | Nonstandard |
| **Ruby** | >= 2.7.0 |

AI toolkit deeply integrated into Rails applications

A comprehensive AI toolkit for Rails with multi-provider support, context awareness, and performance optimizations

**Dependencies:** rails (>= 5.2, < 9), concurrent-ruby (~> 1.0), benchmark-ips (~> 2.10), connection_pool (~> 2.4), memory_profiler (~> 1.0)

## [rails_autolink](https://github.com/tenderlove/rails_autolink)

| | |
|---|---|
| **Version** | 1.1.8 |
| **Authors** | Aaron Patterson, Juanjo Bazan, Akira Matsuda |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Automatic generation of html links in texts

This is an extraction of the `auto_link` method from rails. The `auto_link` method was removed from Rails in version Rails 3.1. This gem is meant to bridge the gap for people migrating.

**Dependencies:** actionview (> 3.1), activesupport (> 3.1), railties (> 3.1)

## [rails_best_practices](https://github.com/flyerhzm/rails_best_practices)

| | |
|---|---|
| **Version** | 1.23.3 |
| **Authors** | Richard Huang |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

a code metric tool for rails codes.

a code metric tool for rails codes, written in Ruby.

**Dependencies:** activesupport (>= 0), code_analyzer (~> 0.5.5), erubis (>= 0), i18n (>= 0), json (>= 0), require_all (~> 3.0), ruby-progressbar (>= 0)

## [rails_charts](https://github.com/railsjazz/rails_charts)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Igor Kasyanchuk, Liubomyr Manastyretskyi |
| **License** | MIT |

One more solution to create charts in Ruby on Rails application

**Dependencies:** rails (>= 0)

## [rails_console_pro](https://github.com/harshumaretiya/rails_console_pro)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Harsh |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Enhanced Rails console with schema inspection, SQL explain, association navigation, and beautiful formatting

Rails Console Pro enhances your Rails console with powerful debugging tools: - Beautiful colored formatting for ActiveRecord objects - Schema inspection with columns, indexes, associations, validations - SQL explain analysis with performance recommendations - Interactive association navigation - Model statistics (record counts, growth rates, table sizes) - Object diffing and comparison - Export to JSON, YAML, and HTML - Smart pagination for large collections

**Dependencies:** pastel (~> 0.8.0), tty-color (~> 0.6.0), pry (>= 0.14.0, < 0.16.0)

## [rails_live_reload](https://github.com/railsjazz/rails_live_reload)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Igor Kasyanchuk, Liubomyr Manastyretskyi |
| **License** | MIT |

Ruby on Rails Live Reload

Ruby on Rails Live Reload with just a single line of code - just add the gem to Gemfile.

**Dependencies:** railties (>= 0), listen (>= 0), websocket-driver (>= 0), nio4r (>= 0)

## [rails_performance](https://github.com/igorkasyanchuk/rails_performance)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Igor Kasyanchuk |
| **License** | MIT |

Simple Rails Performance tracker. Alternative to the NewRelic, Datadog or other services.

3rd party dependency-free solution how to monitor performance of your Rails applications.

**Dependencies:** railties (>= 0), redis (>= 0), browser (>= 0)

## [rails_prompts](https://github.com/Riteshchaudhary710/rails_prompts)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Ritesh Chaudhary |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Manage AI prompts in Rails applications with ERB templates

A Ruby gem for managing AI prompts stored in markdown files with ERB interpolation. Centralizes prompt management and makes them easier to review, version control, and modify.

**Dependencies:** rails (>= 6.0)

## [rails_pulse](https://www.railspulse.com)

| | |
|---|---|
| **Version** | 0.2.4 |
| **Authors** | Rails Pulse |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby on Rails performance monitoring tool.

Ruby on Rails performance monitoring tool that provides insights into your application's performance, helping you identify bottlenecks and optimize your code for better efficiency.

**Dependencies:** rails (>= 7.1.0, < 9.0.0), css-zero (~> 1.1, >= 1.1.4), turbo-rails (~> 2.0.11), request_store (~> 1.5), ransack (~> 4.0), pagy (>= 8, < 44), groupdate (~> 6.0)

## [railties](https://rubyonrails.org)

| | |
|---|---|
| **Version** | 7.2.3 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Tools for creating, working with, and running Rails applications.

Rails internals: application bootup, plugins, generators, and rake tasks.

**Dependencies:** activesupport (= 7.2.3), actionpack (= 7.2.3), cgi (>= 0), rackup (>= 1.0.0), rake (>= 12.2), thor (~> 1.0, >= 1.2.2), zeitwerk (~> 2.6), irb (~> 1.13), tsort (>= 0.2)

## [rainbow](https://github.com/sickill/rainbow)

| | |
|---|---|
| **Version** | 3.1.1 |
| **Authors** | Marcin Kulik, Olle Jonsson |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Colorize printed text on ANSI terminals

## [raix](https://github.com/OlympiaAI/raix)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Obie Fernandez |
| **License** | MIT |
| **Ruby** | >= 3.2.2 |

Ruby AI eXtensions

**Dependencies:** activesupport (>= 6.0), faraday-retry (~> 2.0), open_router (~> 0.2), ostruct (>= 0), ruby-openai (~> 8.1)

## [raix-openai-eight](https://github.com/parrudaj/raix-openai-eight)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Paulo Arruda |
| **License** | MIT |
| **Ruby** | >= 3.2.2 |

Ruby AI eXtensions

**Dependencies:** activesupport (>= 6.0), faraday-retry (~> 2.0), open_router (~> 0.2), ostruct (>= 0), ruby-openai (~> 8.1)

## [raix-rails](https://github.com/OlympiaAI/raix-rails)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Obie Fernandez |
| **License** | MIT |
| **Ruby** | >= 3.2.2 |

Ruby AI eXtensions for Rails

**Dependencies:** activesupport (>= 6.0), open_router (~> 0.2)

## [rake](https://github.com/ruby/rake)

| | |
|---|---|
| **Version** | 12.3.3 |
| **Authors** | Hiroshi SHIBATA, Eric Hodel, Jim Weirich |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Rake is a Make-like program implemented in Ruby

Rake is a Make-like program implemented in Ruby. Tasks and dependencies are specified in standard Ruby syntax. Rake has the following features: * Rakefiles (rake's version of Makefiles) are completely defined in standard Ruby syntax. No XML files to edit. No quirky Makefile syntax to worry about (is that a tab or a space?) * Users can specify tasks with prerequisites. * Rake supports rule patterns to synthesize implicit tasks. * Flexible FileLists that act like arrays but know about manipulating file names and paths. * Supports parallel execution of tasks.

## [rake-compiler](https://github.com/rake-compiler/rake-compiler)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Kouhei Sutou, Luis Lavena |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

Rake-based Ruby Extension (C, Java) task generator.

Provide a standard and simplified way to build and package Ruby extensions (C, Java) using Rake as glue.

**Dependencies:** rake (>= 0)

## [rake-compiler-dock](https://github.com/rake-compiler/rake-compiler-dock)

| | |
|---|---|
| **Version** | 1.11.0 |
| **Authors** | Lars Kanis |
| **License** | MIT |

Easy to use and reliable cross compiler environment for building Windows and Linux binary gems.

Easy to use and reliable cross compiler environment for building Windows and Linux binary gems. Use rake-compiler-dock to enter an interactive shell session or add a task to your Rakefile to automate your cross build.

## [ransack](https://github.com/activerecord-hackery/ransack)

| | |
|---|---|
| **Version** | 4.4.1 |
| **Authors** | Ernie Miller, Ryan Bigg, Jon Atack, Sean Carroll, David Rodríguez |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Object-based searching for Active Record.

Powerful object-based searching and filtering for Active Record with advanced features like complex boolean queries, association searching, custom predicates and i18n support.

**Dependencies:** activerecord (>= 7.2), activesupport (>= 7.2), i18n (>= 0)

## [rapitapir](https://riccardomerolla.github.io/rapitapir/)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Riccardo Merolla |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Type-safe HTTP API development for Ruby

RapiTapir is a Ruby library inspired by Scala's Tapir for building type-safe HTTP APIs. It provides declarative endpoint definitions, automatic OpenAPI documentation generation, client code generation, and seamless integration with Sinatra, Rails, and Rack applications.

**Dependencies:** json (~> 2.0), rack (>= 2.0, < 4.0), webrick (~> 1.7), sinatra (>= 2.0, < 5.0)

## [ratatui_ruby](https://sr.ht/~kerrick/ratatui_ruby/)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Kerrick Long |
| **License** | LGPL-3.0-or-later |
| **Ruby** | >= 3.2.9, < 5 |

💎 Unofficial Ruby wrapper for the Ratatui 👨‍🍳🐀.

== Terminal UIs, the Ruby Way  RatatuiRuby[https://rubygems.org/gems/ratatui_ruby] is a RubyGem built on Ratatui[https://ratatui.rs], a leading TUI library written in Rust[https://rust-lang.org]. You get native performance with the joy of Ruby.  gem install ratatui_ruby  {rdoc-image:https://ratatui-ruby.dev/hero.gif}[https://www.ratatui-ruby.dev/docs/v0.10/examples/app_cli_rich_moments/README_md.html]  === Rich Moments  Add a spinner, a progress bar, or an inline menu to your CLI script. No full-screen takeover. Your terminal history stays intact.  ==== Inline Viewports  Standard TUIs erase themselves on exit. Your carefully formatted CLI output disappears. Users lose their scrollback.  <b>Inline viewports</b> solve this. They occupy a fixed number of lines, render rich UI, then leave the output in place when done.  Perfect for spinners, menus, progress indicators—any brief moment of richness.  require "ratatui_ruby"  RatatuiRuby.run(viewport: :inline, height: 1) do |tui| until connected? status = tui.paragraph(text: "\#{spin} Connecting...") tui.draw { |frame| frame.render_widget(status, frame.area) } end end  === Build Something Real  Full-screen applications with {keyboard and mouse input}[https://www.ratatui-ruby.dev/docs/v0.10/examples/app_all_events/README_md.html]. The managed loop sets up the terminal and restores it on exit, even after crashes.  RatatuiRuby.run do |tui| loop do tui.draw do |frame| frame.render_widget( tui.paragraph(text: "Hello, RatatuiRuby!", alignment: :center), frame.area ) end  case tui.poll_event in { type: :key, code: "q" } then break else nil end end end  ==== Widgets included:  [Layout] {Block}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_block/README_md.html], {Center}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_center/README_md.html], {Clear (Popup, Modal)}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_popup/README_md.html], {Layout (Split, Grid)}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_layout_split/README_md.html], {Overlay}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_overlay/README_md.html] [Data] {Bar Chart}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_barchart/README_md.html], {Chart}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_chart/README_md.html], {Gauge}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_gauge/README_md.html], {Line Gauge}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_line_gauge/README_md.html], {Sparkline}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_sparkline/README_md.html], {Table}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_table/README_md.html] [Text] {Cell}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_cell/README_md.html], {List}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_list/README_md.html], {Rich Text (Line, Span)}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_rich_text/README_md.html], {Scrollbar (Scroll)}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_scrollbar/README_md.html], {Tabs}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_tabs/README_md.html] [Graphics] {Calendar}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_calendar/README_md.html], {Canvas}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_canvas/README_md.html], {Map (World Map)}[https://www.ratatui-ruby.dev/docs/v0.10/examples/widget_map/README_md.html]  Need something else? {Build custom widgets}[https://www.ratatui-ruby.dev/docs/v0.10/doc/concepts/custom_widgets_md.html] in Ruby!   ---  === Testing Built In  TUI testing is tedious. You need a headless terminal, event injection, snapshot comparisons, and style assertions. RatatuiRuby bundles all of it.  require "ratatui_ruby/test_helper"  class TestColorPicker < Minitest::Test include RatatuiRuby::TestHelper  def test_swatch_widget with_test_terminal(10, 3) do RatatuiRuby.draw do |frame| frame.render_widget(Swatch.new(:red), frame.area) end assert_cell_style 2, 1, char: "█", bg: :red end end end  ==== What's inside:  - <b>Headless terminal</b> — No real TTY needed - <b>Snapshots</b> — Plain text and rich (ANSI colors) - <b>Event injection</b> — Keys, mouse, paste, resize - <b>Style assertions</b> — Color, bold, underline at any cell - <b>Test doubles</b> — Mock frames and stub rects - <b>UPDATE_SNAPSHOTS=1</b> — Regenerate baselines in one command   ---  ==== Inline Menu Example  require "ratatui_ruby"  # This example renders an inline menu. Arrow keys select, enter confirms. # The menu appears in-place, preserving scrollback. When the user chooses, # the TUI closes and the script continues with the selected value. class RadioMenu CHOICES = ["Production", "Staging", "Development"]         # ASCII strings are universally supported. PREFIXES = { active: "●", inactive: "○" }                  # Some terminals may not support Unicode. CONTROLS = "↑/↓: Select | Enter: Choose | Ctrl+C: Cancel"  # Let users know what keys you handle. TITLES = ["Select Environment",                            # The default title position is top left. { content: CONTROLS,                             # Multiple titles can save space. position: :bottom,                             # Titles go on the top or bottom, alignment: :right }]                           # aligned left, right, or center  def call                                                   # This method blocks until a choice is made. RatatuiRuby.run(viewport: :inline, height: 5) do |tui|   # RatauiRuby.run manages the terminal. @tui = tui                                             # The TUI instance is safe to store. show_menu until chosen?                                # You can use any loop keyword you like. end                                                      # `run` won't return until your block does, RadioMenu::CHOICES[@choice]                              # so you can use it synchronously. end # Classes like RadioMenu are convenient for private                                                    # CLI authors to offer "rich moments."  def show_menu = @tui.draw do |frame|                       # RatatuiRuby gives you low-level access. widget = @tui.paragraph(                                 # But the TUI facade makes it easy to use. text: menu_items,                                      # Text can be spans, lines, or paragraphs. block: @tui.block(borders: :all, titles: TITLES)       # Blocks give you boxes and titles, and hold )                                                        # one or more widgets. We only use one here, frame.render_widget(widget, frame.area)                  # but "area" lets you compose sub-views. end  def chosen?                                                # You are responsible for handling input. interaction = @tui.poll_event                            # Every frame, you receive an event object: return choose if interaction.enter?                      # Key, Mouse, Resize, Paste, FocusGained, # FocusLost, or None objects. They come with move_by(-1) if interaction.up?                           # predicates, support pattern matching, and move_by(1) if interaction.down?                          # can be inspected for properties directly. quit! if interaction.ctrl_c?                             # Your application must handle every input, false                                                    # even interrupts and other exit patterns. end  def choose                                                 # Here, the loop is about to exit, and the prepare_next_line                                        # block will return. The inline viewport @choice                                                  # will be torn down and the terminal will end                                                        # be restored, but you are responsible for # positioning the cursor. def prepare_next_line                                      # To ensure the next output is on a new area = @tui.viewport_area                                # line, query the viewport area and move RatatuiRuby.cursor_position = [0, area.y + area.height]  # the cursor to the start of the last line. puts                                                     # Then print a newline. end  def quit!                                                  # All of your familiar Ruby control flow prepare_next_line                                        # keywords work as expected, so we can exit 0                                                   # use them to leave the TUI. end  def move_by(line_count)                                    # You are in full control of your UX, so @choice = (@choice + line_count) % CHOICES.size          # you can implement any logic you need: end                                                        # Would you "wrap around" here, or not? # def menu_items = CHOICES.map.with_index do |choice, i|     # Notably, RatatuiRuby has no concept of "\#{prefix_for(i)} \#{choice}"                             # "menus" or "radio buttons". You are in end                                                        # full control, but it also means you must def prefix_for(choice_index)                               # implement the logic yourself. For larger return PREFIXES[:active] if choice_index == @choice      # applications, consider using Rooibos, PREFIXES[:inactive]                                      # an MVU framework built with RatatuiRuby. end                                                        # Or, use the upcoming ratatui-ruby-kit, # our object-oriented component library. def initialize = @choice = 0                               # However, those are both optional, and end                                                          # designed for full-screen Terminal UIs. # RatatuiRuby will always give you the most choice = RadioMenu.new.call                                  # control, and is enough for "rich CLI puts "You chose \#{choice}!"                                  # moments" like this one.  ---  === Full App Solutions  RatatuiRuby renders. For complex applications, add a framework that manages state and composition.  ==== Rooibos[https://git.sr.ht/~kerrick/rooibos] (Framework)  Model-View-Update architecture. Inspired by Elm, Bubble Tea, and React + Redux. Your UI is a pure function of state.  - Functional programming with MVU - Commands work off the main thread - Messages, not callbacks, drive updates  ==== {Kit}[https://sr.ht/~kerrick/ratatui_ruby/#chapter-3-the-object-path--kit] (Coming Soon)  Component-based architecture. Encapsulate state, input handling, and rendering in reusable pieces.  - OOP with stateful components - Separate UI state from domain logic - Built-in focus management & click handling  Both use the same widget library and rendering engine. Pick the paradigm that fits your brain.   ---  === Why RatatuiRuby?  Ruby deserves world-class terminal user interfaces. TUI developers deserve a world-class language.  RatatuiRuby wraps Rust's Ratatui via native extension. The Rust library handles rendering. Your Ruby code handles design.  >>> "Text UIs are seeing a renaissance with many new TUI libraries popping up. The Ratatui bindings have proven to be full featured and stable."  — {Mike Perham}[https://www.mikeperham.com/], creator of Sidekiq[https://sidekiq.org/] and Faktory[https://contribsys.com/faktory/]  ==== Why Rust? Why Ruby?  Rust excels at low-level rendering. Ruby excels at expressing domain logic and UI. RatatuiRuby puts each language where it performs best.  ==== Versus CharmRuby  CharmRuby[https://charm-ruby.dev/] wraps Charm's Go libraries. Both projects give Ruby developers TUI options.  [Integration] CharmRuby: Two runtimes, one process. RatatuiRuby: Native extension in Rust. [Runtime] CharmRuby: Go + Ruby (competing). RatatuiRuby: Ruby (Rust has no runtime). [Memory] CharmRuby: Two uncoordinated GCs. RatatuiRuby: One Garbage Collector. [Style] CharmRuby: The Elm Architecture (TEA). RatatuiRuby: TEA, OOP, or Imperative.   ---  === Links  [Get Started] {Quickstart}[https://www.ratatui-ruby.dev/docs/v0.10/doc/getting_started/quickstart_md.html], {Examples}[https://www.ratatui-ruby.dev/docs/v0.10/examples/app_cli_rich_moments/README_md.html], {API Reference}[https://www.ratatui-ruby.dev/docs/v0.10/], {Guides}[https://www.ratatui-ruby.dev/docs/v0.10/doc/index_md.html] [Ecosystem] Rooibos[https://git.sr.ht/~kerrick/rooibos], {Kit}[https://sr.ht/~kerrick/ratatui_ruby/#chapter-3-the-object-path--kit] (Planned), {Framework}[https://sr.ht/~kerrick/ratatui_ruby/#chapter-5-the-framework] (Planned), {UI Widgets}[https://sr.ht/~kerrick/ratatui_ruby/#chapter-6-licensing] (Planned) [Community] {Discuss and Chat}[https://lists.sr.ht/~kerrick/ratatui_ruby-discuss], {Announcements}[https://lists.sr.ht/~kerrick/ratatui_ruby-announce], {Development}[https://lists.sr.ht/~kerrick/ratatui_ruby-devel], {Bug Tracker}[https://todo.sr.ht/~kerrick/ratatui_ruby] [Contribute] {Contributing Guide}[https://man.sr.ht/~kerrick/ratatui_ruby/contributing.md], {Code of Conduct}[https://man.sr.ht/~kerrick/ratatui_ruby/code_of_conduct.md], {Project History}[https://man.sr.ht/~kerrick/ratatui_ruby/history/index.md], {Pull Requests}[https://lists.sr.ht/~kerrick/ratatui_ruby-devel/patches]   ---  [Website] https://www.ratatui-ruby.dev [Source] https://git.sr.ht/~kerrick/ratatui_ruby [RubyGems] https://rubygems.org/gems/ratatui_ruby [Upstream] https://ratatui.rs [Build Status] https://builds.sr.ht/~kerrick/ratatui_ruby  © 2026 Kerrick Long · Library: LGPL-3.0-or-later · Website: CC-BY-NC-ND-4.0 · Snippets: MIT-0

**Dependencies:** rb_sys (~> 0.9), rexml (~> 3.4)

## [rb-fsevent](http://rubygems.org/gems/rb-fsevent)

| | |
|---|---|
| **Version** | 0.11.2 |
| **Authors** | Thibaud Guillaume-Gentil, Travis Tilley |
| **License** | MIT |

Very simple & usable FSEvents API

FSEvents API with Signals catching (without RubyCocoa)

## [rb-inotify](https://github.com/guard/rb-inotify)

| | |
|---|---|
| **Version** | 0.11.1 |
| **Authors** | Natalie Weizenbaum, Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 2.5 |

A Ruby wrapper for Linux inotify, using FFI

**Dependencies:** ffi (~> 1.0)

## [rb_sys](https://oxidize-rb.github.io/rb-sys/)

| | |
|---|---|
| **Version** | 0.9.124 |
| **Authors** | Ian Ker-Seymer |
| **License** | MIT, Apache-2.0 |
| **Ruby** | >= 2.7.0 |

Helpers for compiling Rust extensions for ruby

**Dependencies:** rake-compiler-dock (= 1.11.0)

## [rbayes](http://seattlerb.rubyforge.org/rbayes/)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Eric Hodel |
| **Ruby** | > 0.0.0 |

An email-focused bayesian filter

An bayesian filter fed by a tokenizer that throws crap out you'd find in emails.  Originally by Dan Peterson

**Dependencies:** hoe (>= 1.1.6)

## [rbcat](https://github.com/vifreefly/rbcat)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Victor Afanasev |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Colorize output by defined set of regex rules

## [rbnacl](https://github.com/RubyCrypto/rbnacl)

| | |
|---|---|
| **Version** | 7.1.2 |
| **Authors** | Tony Arcieri, Jonathan Stott |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Ruby binding to the libsodium/NaCl cryptography library

The Networking and Cryptography (NaCl) library provides a high-level toolkit for building cryptographic systems and protocols

**Dependencies:** ffi (~> 1)

## [rbs](https://github.com/ruby/rbs)

| | |
|---|---|
| **Version** | 3.10.3 |
| **Authors** | Soutaro Matsumoto |
| **License** | BSD-2-Clause, Ruby |
| **Ruby** | >= 3.1 |

Type signature for Ruby.

RBS is the language for type signatures for Ruby and standard library definitions.

**Dependencies:** logger (>= 0), tsort (>= 0)

## [rbs-inline](https://github.com/soutaro/rbs-inline)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | Soutaro Matsumoto |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Inline RBS type declaration.

**Dependencies:** prism (>= 0.29), rbs (>= 3.8.0)

## [rbs_goose](https://github.com/kokuyouwind/rbs_goose)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | kokuyouwind |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

RBS type inferrer with LLM

**Dependencies:** faraday (>= 2.9.0, < 3.0.0), langchainrb (>= 0.12.0, < 1.0.0), steep (>= 1.6.0, < 2.0.0), anthropic (>= 0.2.0, < 1.0.0), orthoses (>= 1.13.0, < 2.0.0), ruby-openai (>= 6.1.0, < 8.0.0)

## [rbtree](http://rbtree.rubyforge.org/)

| | |
|---|---|
| **Version** | 0.4.6 |
| **Authors** | OZAWA Takuma |
| **License** | MIT |
| **Ruby** | >= 1.8.6 |

A sorted associative collection.

A RBTree is a sorted associative collection that is implemented with a Red-Black Tree. It maps keys to values like a Hash, but maintains its elements in ascending key order. The interface is the almost identical to that of Hash.

## [rbvmomi2](https://github.com/ManageIQ/rbvmomi2)

| | |
|---|---|
| **Version** | 3.8.0 |
| **Authors** | Adam Grare, Jason Frey |
| **License** | MIT |
| **Ruby** | >= 2.4.1 |

Ruby interface to the VMware vSphere API

**Dependencies:** builder (~> 3.2), json (~> 2.3), nokogiri (>= 1.12.5, ~> 1.12), optimist (~> 3.0)

## [rchardet](https://github.com/jmhodges/rchardet)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | Michael Grosser, Jeff Hodges |
| **License** | LGPL |
| **Ruby** | >= 3.0.0 |

Character encoding auto-detection in Ruby. As smart as your browser. Open source.

## [rdoc](https://ruby.github.io/rdoc)

| | |
|---|---|
| **Version** | 6.17.0 |
| **Authors** | Eric Hodel, Dave Thomas, Phil Hagelberg, Tony Strauss, Zachary Scott, Hiroshi SHIBATA, ITOYANAGI Sakura |
| **License** | Ruby |
| **Ruby** | >= 2.6.0 |

RDoc produces HTML and command-line documentation for Ruby projects

RDoc produces HTML and command-line documentation for Ruby projects. RDoc includes the +rdoc+ and +ri+ tools for generating and displaying documentation from the command-line.

**Dependencies:** psych (>= 4.0.0), erb (>= 0), tsort (>= 0)

## [re2](https://github.com/mudge/re2)

| | |
|---|---|
| **Version** | 2.23.0 |
| **Authors** | Paul Mucur, Stan Hu |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.1, < 4.1.dev |

Ruby bindings to RE2.

Ruby bindings to RE2, "a fast, safe, thread-friendly alternative to backtracking regular expression engines like those used in PCRE, Perl, and Python".

## [react_to_rails](https://github.com/andyw8/react_to_rails)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Andy Waite |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Converts React components to Rails using AI

**Dependencies:** openai (~> 0.6), zeitwerk (~> 2.7)

## [reactionview](https://reactionview.dev)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

An ActionView-compatible ERB engine with modern DX - re-imagined with Herb.

**Dependencies:** actionview (>= 7.0), herb (>= 0.8.0, < 1.0.0)

## [readline](https://github.com/ruby/readline)

| | |
|---|---|
| **Version** | 0.0.4 |
| **Authors** | aycabta |
| **License** | Ruby |

Loader for "readline".

This is just a loader for "readline". If Ruby has the "readline-ext" gem that is a native extension, this gem will load it. If Ruby does not have the "readline-ext" gem this gem will load "reline", a library that is compatible with the "readline-ext" gem and implemented in pure Ruby.

**Dependencies:** reline (>= 0)

## [reclassifier](https://github.com/saveup/reclassifier)

| | |
|---|---|
| **Version** | 0.4.11 |
| **Authors** | Ryan Oblak |
| **License** | LGPL |

Bayesian and Latent Semantic Indexing classification of text.

**Dependencies:** fast-stemmer (>= 0), activesupport (>= 0)

## [recursive-open-struct](https://github.com/aetherknight/recursive-open-struct)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | William (B.J.) Snow Orvis |
| **License** | MIT |

OpenStruct subclass that returns nested hash attributes as RecursiveOpenStructs

RecursiveOpenStruct is a subclass of OpenStruct. It differs from OpenStruct in that it allows nested hashes to be treated in a recursive fashion. For example:  ros = RecursiveOpenStruct.new({ :a => { :b => 'c' } }) ros.a.b # 'c'  Also, nested hashes can still be accessed as hashes:  ros.a_as_a_hash # { :b => 'c' }

**Dependencies:** ostruct (>= 0)

## [redcarpet](https://github.com/vmg/redcarpet)

| | |
|---|---|
| **Version** | 3.6.1 |
| **Authors** | Natacha Porté, Vicent Martí |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

Markdown that smells nice

A fast, safe and extensible Markdown to (X)HTML parser

## [redis](https://github.com/redis/redis-rb)

| | |
|---|---|
| **Version** | 5.4.1 |
| **Authors** | Ezra Zygmuntowicz, Taylor Weibley, Matthew Clark, Brian McKinney, Salvatore Sanfilippo, Luca Guidi, Michel Martens, Damian Janowski, Pieter Noordhuis |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A Ruby client library for Redis

A Ruby client that tries to match Redis' API one-to-one, while still providing an idiomatic interface.

**Dependencies:** redis-client (>= 0.22.0)

## [redis-client](https://github.com/redis-rb/redis-client)

| | |
|---|---|
| **Version** | 0.26.4 |
| **Authors** | Jean Boussier |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Simple low-level client for Redis 6+

**Dependencies:** connection_pool (>= 0)

## [redis-namespace](https://github.com/resque/redis-namespace)

| | |
|---|---|
| **Version** | 1.11.0 |
| **Authors** | Chris Wanstrath, Terence Lee, Steve Klabnik, Ryan Biesemeyer, Mike Bianco |
| **License** | MIT |
| **Ruby** | >= 2.4 |

Namespaces Redis commands.

Adds a Redis::Namespace class which can be used to namespace calls to Redis. This is useful when using a single instance of Redis with multiple, different applications.

**Dependencies:** redis (>= 4)

## [redlock](https://github.com/leandromoreira/redlock-rb)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Leandro Moreira |
| **License** | BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Distributed lock using Redis written in Ruby.

Distributed lock using Redis written in Ruby. Highly inspired by https://github.com/antirez/redlock-rb.

**Dependencies:** redis-client (>= 0.14.1, < 1.0.0)

## [reek](https://github.com/troessner/reek)

| | |
|---|---|
| **Version** | 6.5.0 |
| **Authors** | Kevin Rutherford, Timo Roessner, Matijs van Zuijlen, Piotr Szotkowski |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Code smell detector for Ruby

Reek is a tool that examines Ruby classes, modules and methods and reports any code smells it finds.

**Dependencies:** dry-schema (~> 1.13), logger (~> 1.6), parser (~> 3.3.0), rainbow (>= 2.0, < 4.0), rexml (~> 3.1)

## [refer](https://github.com/excid3/refer)

| | |
|---|---|
| **Version** | 1.0.4 |
| **Authors** | Chris Oliver |
| **License** | MIT |

Referral codes & affiliate links for Ruby on Rails apps

**Dependencies:** rails (>= 7.1.0)

## [refinements](https://alchemists.io/projects/refinements)

| | |
|---|---|
| **Version** | 13.6.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A collection of core object refinements.

## [reform](https://github.com/trailblazer/reform)

| | |
|---|---|
| **Version** | 2.6.2 |
| **Authors** | Nick Sutterer, Fran Worley |
| **License** | MIT |

Form object decoupled from models with validation, population and presentation.

Form object decoupled from models.

**Dependencies:** disposable (>= 0.5.0, < 1.0.0), representable (>= 3.1.1, < 4), uber (< 0.2.0)

## [refract](https://github.com/yippee-fun/refract)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Joel Drapper |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Ruby code rewriter.

**Dependencies:** prism (>= 0), zeitwerk (>= 0)

## [refrigerator](http://github.com/jeremyevans/ruby-refrigerator)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Jeremy Evans |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

Freeze all core ruby classes

Refrigerator freezes all core classes.  It is designed to be used in production, to make sure that none of the core classes are modified at runtime.  It can also be used to check libraries to make sure that they don't make unexpected modifications/monkey patches to core classes.

## [regent](https://github.com/alchaplinsky/regent)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Alex Chaplinsky |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Library for building AI Agents in Ruby

Regent is a library for building AI Agents that utilize tools to accomplish tasks. Current implementation is based on the ReAct Agent architecture.

**Dependencies:** faraday (~> 2.12), zeitwerk (~> 2.7), tty-spinner (~> 0.9.3), pastel (~> 0.8.0)

## [regexp_parser](https://github.com/ammar/regexp_parser)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Ammar Ali |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Scanner, lexer, parser for ruby's regular expressions

A library for tokenizing, lexing, and parsing Ruby regular expressions.

## [regexp_property_values](https://github.com/jaynetics/regexp_property_values)

| | |
|---|---|
| **Version** | 1.5.2 |
| **Authors** | Janosch Müller |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

Inspect property values supported by Ruby's regex engine

This small library lets you see which property values are supported by the regular expression engine of the Ruby version you are running, and what they match.

## [rein](http://github.com/nullobject/rein)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | Joshua Bassett |
| **License** | MIT |

Database constraints made easy for ActiveRecord.

Rein adds bunch of methods to your ActiveRecord migrations so you can easily tame your database.

**Dependencies:** activerecord (>= 4.0.0), activesupport (>= 4.0.0)

## [reline](https://github.com/ruby/reline)

| | |
|---|---|
| **Version** | 0.6.3 |
| **Authors** | aycabta |
| **License** | Ruby |
| **Ruby** | >= 2.6 |

Alternative GNU Readline or Editline implementation by pure Ruby.

**Dependencies:** io-console (~> 0.5)

## [repl_type_completor](https://github.com/ruby/repl_type_completor)

| | |
|---|---|
| **Version** | 0.1.13 |
| **Authors** | tompng |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Type based completion for REPL.

**Dependencies:** prism (~> 1.0), rbs (>= 2.7.0, < 4.0.0)

## [reporter](https://github.com/matthijsgroen/reporter)

| | |
|---|---|
| **Version** | 0.0.5 |
| **Authors** | Matthijs Groen |

Report builder.

Reporter adds a consistent way to build reports.

**Dependencies:** arel (>= 0), activerecord (~> 3.0), activesupport (~> 3.0)

## [representable](https://github.com/trailblazer/representable/)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Nick Sutterer |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Renders and parses JSON/XML/YAML documents from and to Ruby objects. Includes plain properties, collections, nesting, coercion and more.

**Dependencies:** uber (< 0.2.0), declarative (< 0.1.0), trailblazer-option (>= 0.1.1, < 0.2.0)

## [request_store](https://github.com/steveklabnik/request_store)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Steve Klabnik |
| **License** | MIT |

RequestStore gives you per-request global storage.

**Dependencies:** rack (>= 1.4)

## [requestkit](https://requestkit.railsdesigner.com/)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Rails Designer Developers |
| **License** | MIT |
| **Ruby** | >= 3.4.0 |

Local HTTP request toolkit

Capture webhooks and send HTTP requests locally. Think webhook.site meets Postman, but living on your machine where it belongs.

**Dependencies:** async-http (~> 0.90), sqlite3 (~> 2.7)

## [require-hooks](https://github.com/ruby-next/require-hooks)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.2 |

Require Hooks provide infrastructure for intercepting require/load calls in Ruby.

Require Hooks provide infrastructure for intercepting require/load calls in Ruby

## [require_all](http://github.com/jarmo/require_all)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Jarmo Pertman, Tony Arcieri |
| **License** | MIT |

A wonderfully simple way to load your code

## [requires](https://github.com/dannyben/requires)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Danny Ben Shitrit |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Require all files in a directory

Adds functions that allow requiring a direcotry

## [rerun](http://github.com/alexch/rerun/)

| | |
|---|---|
| **Version** | 0.14.0 |
| **Authors** | Alex Chaffee |
| **License** | MIT |

Launches an app, and restarts it whenever the filesystem changes. A no-frills, command-line alternative to Guard, Shotgun, Autotest, etc.

Restarts your app when a file changes. A no-frills, command-line alternative to Guard, Shotgun, Autotest, etc.

**Dependencies:** listen (~> 3.0)

## [resolv](https://github.com/ruby/resolv)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Thread-aware DNS resolver library in Ruby.

## [resolv-replace](https://github.com/ruby/resolv-replace)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Replace Socket DNS with Resolv.

**Dependencies:** resolv (>= 0)

## [responders](https://github.com/heartcombo/responders)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | José Valim |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A set of Rails responders to dry up your application

**Dependencies:** railties (>= 7.0), actionpack (>= 7.0)

## [resque](https://github.com/resque/resque)

| | |
|---|---|
| **Version** | 2.7.0 |
| **Authors** | Chris Wanstrath, Steve Klabnik, Terence Lee, Michael Bianco |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Resque is a Redis-backed queueing system.

Resque is a Redis-backed Ruby library for creating background jobs, placing those jobs on multiple queues, and processing them later.  Background jobs can be any Ruby class or module that responds to perform. Your existing classes can easily be converted to background jobs or you can create new classes specifically to do work. Or, you can do both.  Resque is heavily inspired by DelayedJob (which rocks) and is comprised of three parts:  * A Ruby library for creating, querying, and processing jobs * A Rake task for starting a worker which processes jobs * A Sinatra app for monitoring queues, jobs, and workers.

**Dependencies:** redis-namespace (~> 1.6), sinatra (>= 0.9.2), multi_json (~> 1.0), mono_logger (~> 1)

## [resque-pool](http://github.com/nevans/resque-pool)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | nicholas a. evans |
| **License** | MIT |
| **Ruby** | >= 2.0 |

quickly and easily fork a pool of resque workers

quickly and easily fork a pool of resque workers, saving memory (w/REE) and monitoring their uptime

**Dependencies:** resque (>= 1.22, < 3), rake (>= 10.0, < 14.0)

## [rest-client](https://github.com/rest-client/rest-client)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | REST Client Team |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Simple HTTP and REST client for Ruby, inspired by microframework syntax for specifying actions.

A simple HTTP and REST client for Ruby, inspired by the Sinatra microframework style of specifying actions: get, put, post, delete.

**Dependencies:** http-accept (>= 1.7.0, < 2.0), http-cookie (>= 1.0.2, < 2.0), mime-types (>= 1.16, < 4.0), netrc (~> 0.8)

## [retest](https://github.com/AlexB52/retest)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Alexandre Barret |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A simple command line tool to watch file change and run its matching spec.

**Dependencies:** string-similarity (~> 2.1), listen (~> 3.9), tty-option (~> 0.1), tty-prompt (~> 0.1), observer (~> 0.1)

## [rethinkdb](https://rethinkdb.com)

| | |
|---|---|
| **Version** | 2.4.0.0 |
| **Authors** | RethinkDB Inc. |
| **License** | Apache-2.0 |
| **Ruby** | >= 1.9.0 |

This package provides the Ruby driver library for the RethinkDB database server.

## [rethinkdb_helper](https://github.com/MadBomber/rethinkdb_helper)

| | |
|---|---|
| **Version** | 0.0.4 |
| **Authors** | Dewayne VanHoozer |
| **License** | You want it?  It's yours. |

A wrapper around the ruby rethinkdb gem

The rethinkDB is an interesting NoSQL massively scalable open source project.  It may have some impact on the real-time processing community.  This little gem is just a convention wrapper around the official rethinkdb.  Its my conventions which are subject to change at a momments notice.  I would not use this gem if I were you.

**Dependencies:** rethinkdb (~> 2)

## [retriable](http://github.com/kamui/retriable)

| | |
|---|---|
| **Version** | 3.1.2 |
| **Authors** | Jack Chu |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Retriable is a simple DSL to retry failed code blocks with randomized exponential backoff

Retriable is a simple DSL to retry failed code blocks with randomized exponential backoff. This is especially useful when interacting external api/services or file system calls.

## [reverse_markdown](http://github.com/xijo/reverse_markdown)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | Johannes Opper |
| **License** | WTFPL |

Convert html code into markdown.

Map simple html back into markdown, e.g. if you want to import existing html data in your application.

**Dependencies:** nokogiri (>= 0)

## [rexe](https://github.com/keithrbennett/rexe)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Keith Bennett |
| **License** | MIT |

Ruby Command Line Executor

**Dependencies:** awesome_print (>= 0)

## [rexml](https://github.com/ruby/rexml)

| | |
|---|---|
| **Version** | 3.3.9 |
| **Authors** | Kouhei Sutou |
| **License** | BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

An XML toolkit for Ruby

## [rgeo](https://github.com/rgeo/rgeo)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Daniel Azuma, Tee Parham |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.1.4 |

RGeo is a geospatial data library for Ruby.

RGeo is a geospatial data library for Ruby. It provides an implementation of the Open Geospatial Consortium's Simple Features Specification, used by most standard spatial/geographic data storage systems such as PostGIS. A number of add-on modules are also available to help with writing location-based applications using Ruby-based frameworks such as Ruby On Rails.

## [rgeo-activerecord](https://github.com/rgeo/rgeo-activerecord)

| | |
|---|---|
| **Version** | 8.1.0 |
| **Authors** | Daniel Azuma, Tee Parham |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.1.0 |

An RGeo module providing spatial extensions to ActiveRecord.

RGeo is a geospatial data library for Ruby. RGeo::ActiveRecord is an optional RGeo module providing some spatial extensions to ActiveRecord, as well as common tools used by RGeo-based spatial adapters.

**Dependencies:** activerecord (>= 8.1, < 8.2), rgeo (>= 3.0)

## [rice](https://github.com/ruby-rice/rice)

| | |
|---|---|
| **Version** | 4.9.1 |
| **Authors** | Paul Brannan, Jason Roelofs, Charlie Savage |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Ruby Interface for C++ Extensions

Rice is a C++ interface to Ruby's C API. It provides a type-safe and exception-safe interface in order to make embedding Ruby and writing Ruby extensions with C++ easier.

## [rinda](https://github.com/ruby/rinda)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Masatoshi SEKI |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

The Linda distributed computing paradigm in Ruby.

**Dependencies:** drb (>= 0), ipaddr (>= 0), forwardable (>= 0)

## [rinku](https://github.com/vmg/rinku)

| | |
|---|---|
| **Version** | 2.0.6 |
| **Authors** | Vicent Marti |
| **License** | ISC |
| **Ruby** | >= 2.0.0 |

Mostly autolinking

A fast and very smart autolinking library that acts as a drop-in replacement for Rails `auto_link`

## [ripper-tags](https://github.com/tmm1/ripper-tags)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Mislav Marohnić, Aman Gupta |
| **License** | MIT |
| **Ruby** | >= 1.9 |

ctags generator for ruby code

fast, accurate ctags generator for ruby source code using Ripper

## [rllama](https://rubygems.org/gems/rllama)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Pete Matsyburka |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Ruby bindings for Llama API

Ruby bindings for Llama.cpp to run local LLMs in Ruby applications.

**Dependencies:** ffi (>= 1.0)

## [rmagick](https://github.com/rmagick/rmagick)

| | |
|---|---|
| **Version** | 6.1.5 |
| **Authors** | Tim Hunter, Omer Bar-or, Benjamin Thomas, Moncef Maiza |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby binding to ImageMagick

RMagick is an interface between Ruby and ImageMagick.

**Dependencies:** observer (~> 0.1), pkg-config (~> 1.4)

## [ro](https://github.com/ahoward/ro)

| | |
|---|---|
| **Version** | 5.2.0 |
| **Authors** | Ara T. Howard |
| **License** | Nonstandard |
| **Ruby** | >= 3.0 |

all your content in github, as god intended

the worlds tiniest, bestest, most minmialist headless cms - powered by github  ro is a minimalist toolkit for managing heterogeneous collections of rich web content on github, and providing both programatic and api access to it with zero heavy lifting

**Dependencies:** map (~> 6.6, >= 6.6.0), kramdown (~> 2.4, >= 2.4.0), kramdown-parser-gfm (~> 1.1, >= 1.1.0), rouge (~> 4.1, >= 4.1.1), front_matter_parser (~> 1.0), rinku (~> 2.0), image_size (~> 3.4), nokogiri (~> 1)

## [roast-ai](https://github.com/Shopify/roast)

| | |
|---|---|
| **Version** | 0.5.2 |
| **Authors** | Shopify |
| **License** | MIT |

A framework for executing structured AI workflows in Ruby

Roast is a Ruby library for running structured AI workflows along with many building blocks for creating and executing them

**Dependencies:** activesupport (>= 7.0), async (>= 2.34), benchmark (>= 0.4.1), cli-kit (>= 5.2), cli-ui (>= 2.7), diff-lcs (>= 1.5), json-schema (>= 5.1), open_router (>= 0.3), raix (~> 1.0.2), rake (>= 13.3.0), ruby-graphviz (>= 1.2), ruby_llm (>= 1.8), sqlite3 (>= 2.6), thor (>= 1.3), zeitwerk (>= 2.6)

## [robot_lab](https://github.com/MadBomber/robot_lab)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Ruby framework for building and orchestrating multi-robot LLM workflows

RobotLab is a Ruby framework for building and orchestrating multi-robot LLM workflows. Built on ruby_llm, it provides robots with template-based prompts, tools, and shared memory; networks for coordinating multiple robots with intelligent routing; MCP (Model Context Protocol) integration for external tool servers; a memory system with Redis backend and semantic caching; and Rails integration with generators and ActiveRecord- backed conversation history.

**Dependencies:** zeitwerk (~> 2.6), ruby_llm (~> 1.0), ruby_llm-mcp (>= 0), ruby_llm-template (>= 0), ruby_llm-schema (>= 0), ruby_llm-semantic_cache (>= 0), fastembed (>= 0), async (~> 2.0), simple_flow (~> 0.3.0), state_machines (>= 0), state_machines-activemodel (>= 0), state_machines-activerecord (>= 0), async-http (~> 0.60), async-websocket (~> 0.30), railties (>= 7.0), activerecord (>= 7.0), activesupport (>= 7.0)

## [roda](https://roda.jeremyevans.net)

| | |
|---|---|
| **Version** | 3.100.0 |
| **Authors** | Jeremy Evans |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

Routing tree web toolkit

**Dependencies:** rack (>= 0)

## [rodf](https://github.com/thiagoarrais/rodf)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Weston Ganger, Thiago Arrais |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

This is a library for writing to ODF output from Ruby. It mainly focuses creating ODS spreadsheets.

ODF generation library for Ruby

**Dependencies:** builder (>= 3.0), rubyzip (>= 1.0)

## [role_fu](https://github.com/alec-c4/role_fu)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Alexey Poimtsev |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A modern role management gem for Rails, replacing rolify.

RoleFu provides explicit role management with Role and RoleAssignment models, avoiding hidden HABTM tables. Supports scopes, resource-specific roles, and cleaner architecture.

**Dependencies:** activerecord (>= 7.2)

## [rolify](https://github.com/RolifyCommunity/rolify)

| | |
|---|---|
| **Version** | 6.0.1 |
| **Authors** | Florent Monbillard, Wellington Cordeiro |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Roles library with resource scoping

Very simple Roles library without any authorization enforcement supporting scope on resource objects (instance or class). Supports ActiveRecord and Mongoid ORMs.

## [rom](http://rom-rb.org)

| | |
|---|---|
| **Version** | 5.4.3 |
| **Authors** | Piotr Solnica |
| **License** | MIT |

Persistence and mapping toolkit for Ruby

**Dependencies:** rom-changeset (~> 5.4), rom-core (~> 5.4), rom-repository (~> 5.4, >= 5.4.3)

## [rom-changeset](http://rom-rb.org)

| | |
|---|---|
| **Version** | 5.4.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |

Changeset abstraction for rom-rb

rom-changeset adds support for preprocessing data on top of rom-rb repositories

**Dependencies:** dry-core (~> 1.0), rom-core (~> 5.4), transproc (~> 1.1)

## [rom-core](http://rom-rb.org)

| | |
|---|---|
| **Version** | 5.4.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Ruby Object Mapper

Persistence and mapping toolkit for Ruby

**Dependencies:** concurrent-ruby (~> 1.1), dry-configurable (~> 1.0), dry-core (~> 1.0), dry-inflector (~> 1.0), dry-initializer (~> 3.2), dry-struct (~> 1.0), dry-types (~> 1.6), transproc (~> 1.1)

## [rom-repository](http://rom-rb.org)

| | |
|---|---|
| **Version** | 5.4.3 |
| **Authors** | Piotr Solnica |
| **License** | MIT |

Repository abstraction for rom-rb

**Dependencies:** dry-core (~> 1.0), dry-initializer (~> 3.2), rom-core (~> 5.4)

## [rom-sql](http://rom-rb.org)

| | |
|---|---|
| **Version** | 3.7.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

SQL databases support for ROM

**Dependencies:** sequel (>= 4.49), dry-types (~> 1.8), dry-core (~> 1.1), rom (~> 5.4)

## [roo](https://github.com/roo-rb/roo)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Thomas Preymesser, Hugh McGowan, Ben Woosley, Oleksandr Simonov, Steven Daniels, Anmol Chopra |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Roo can access the contents of various spreadsheet files.

Roo can access the contents of various spreadsheet files. It can handle * OpenOffice * Excelx * LibreOffice * CSV

**Dependencies:** base64 (~> 0.2), csv (~> 3), logger (~> 1), nokogiri (~> 1), rubyzip (>= 3.0.0, < 4.0.0)

## [rotp](https://github.com/mdp/rotp)

| | |
|---|---|
| **Version** | 6.3.0 |
| **Authors** | Mark Percival |
| **License** | MIT |
| **Ruby** | >= 2.3 |

A Ruby library for generating and verifying one time passwords

Works for both HOTP and TOTP, and includes QR Code provisioning

## [rouge](http://rouge.jneen.net/)

| | |
|---|---|
| **Version** | 3.26.0 |
| **Authors** | Jeanine Adkisson |
| **License** | MIT, BSD-2-Clause |
| **Ruby** | >= 2.0 |

A pure-ruby colorizer based on pygments

Rouge aims to a be a simple, easy-to-extend drop-in replacement for pygments.

## [rover-df](https://github.com/ankane/rover)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Simple, powerful data frames for Ruby

**Dependencies:** numo-narray (>= 0.9.1.9)

## [rqrcode](https://github.com/whomwah/rqrcode)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Duncan Robertson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A library to encode QR Codes

rqrcode is a library for encoding QR Codes. The simple interface allows you to create QR Code data structures and then render them in the way you choose.

**Dependencies:** chunky_png (~> 1.0), rqrcode_core (~> 2.0)

## [rqrcode_core](https://github.com/whomwah/rqrcode_core)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Duncan Robertson |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A library to encode QR Codes

rqrcode_core is a Ruby library for encoding QR Codes. The simple interface (with no runtime dependencies) allows you to create QR Code data structures.

## [rrbayes](http://github.com/hungryblank/rrbayes)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | hungryblank |

Rrbayes: Ruby Redis Bayes

Implementation of a naive Bayes classifier with a Redis backend

**Dependencies:** redis (>= 2.0.0)

## [rspec](https://rspec.info)

| | |
|---|---|
| **Version** | 3.13.2 |
| **Authors** | Steven Baker, David Chelimsky, Myron Marston |
| **License** | MIT |

rspec-3.13.2

BDD for Ruby

**Dependencies:** rspec-core (~> 3.13.0), rspec-expectations (~> 3.13.0), rspec-mocks (~> 3.13.0)

## [rspec-core](https://rspec.info)

| | |
|---|---|
| **Version** | 3.13.6 |
| **Authors** | Steven Baker, David Chelimsky, Chad Humphries, Myron Marston |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

rspec-core-3.13.6

BDD for Ruby. RSpec runner and example groups.

**Dependencies:** rspec-support (~> 3.13.0)

## [rspec-difftastic](https://github.com/sealocal/rspec-difftastic)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | Mike Taylor |
| **License** | MIT |

Use difftastic in place of RSpec's default differ.

This is a quick patch implementation and may not cover edge cases.

**Dependencies:** difftastic (~> 0.6.0)

## [rspec-expectations](https://rspec.info)

| | |
|---|---|
| **Version** | 3.13.5 |
| **Authors** | Steven Baker, David Chelimsky, Myron Marston |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

rspec-expectations-3.13.5

rspec-expectations provides a simple, readable API to express expected outcomes of a code example.

**Dependencies:** rspec-support (~> 3.13.0), diff-lcs (>= 1.2.0, < 2.0)

## [rspec-instafail](https://github.com/grosser/rspec-instafail)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Michael Grosser |
| **License** | MIT |

Show failing specs instantly

**Dependencies:** rspec (>= 0)

## [rspec-llama](https://github.com/aifoundry-org/rspec-llama)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Vadim S., Artur A., Anatoli L., Sergy S. |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.2 |

A versatile testing framework for different AI model configurations.

RSpec::Llama is a testing framework that allows developers to easily configure, run, and validate AI models such as OpenAI's GPT models, Llama, and others within the RSpec ecosystem.  With a focus on simplicity and extensibility, RSpec::Llama provides: - A standardized approach to configuring different AI models with customizable parameters. - Runners to execute model interactions and capture responses seamlessly. - Comprehensive assertion types to validate model outputs against expected patterns.  Whether you are developing AI-powered applications or simply need a reliable way to test various AI models' outputs, RSpec::Llama offers an all-in-one solution that integrates smoothly into your existing RSpec setup.

**Dependencies:** rspec (~> 3.0)

## [rspec-mocks](https://rspec.info)

| | |
|---|---|
| **Version** | 3.13.7 |
| **Authors** | Steven Baker, David Chelimsky, Myron Marston |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

rspec-mocks-3.13.7

RSpec's 'test double' framework, with support for stubbing and mocking

**Dependencies:** rspec-support (~> 3.13.0), diff-lcs (>= 1.2.0, < 2.0)

## [rspec-rails](https://github.com/rspec/rspec-rails)

| | |
|---|---|
| **Version** | 8.0.2 |
| **Authors** | David Chelimsky, Andy Lindeman |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

RSpec for Rails

rspec-rails integrates the Rails testing helpers into RSpec.

**Dependencies:** actionpack (>= 7.2), activesupport (>= 7.2), railties (>= 7.2), rspec-core (~> 3.13), rspec-expectations (~> 3.13), rspec-mocks (~> 3.13), rspec-support (~> 3.13)

## [rspec-support](https://rspec.info)

| | |
|---|---|
| **Version** | 3.13.7 |
| **Authors** | David Chelimsky, Myron Marson, Jon Rowe, Sam Phippen, Xaviery Shay, Bradley Schaefer |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

rspec-support-3.13.7

Support utilities for RSpec gems

## [rspec-uuid](https://github.com/dpep/rspec-uuid)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Daniel Pepper |
| **License** | MIT |
| **Ruby** | >= 3 |

RSpec::UUID

RSpec UUID matcher

**Dependencies:** rspec-expectations (>= 3)

## [rspec_junit_formatter](https://github.com/sj26/rspec_junit_formatter)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Samuel Cochran |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

RSpec JUnit XML formatter

RSpec results that your continuous integration service can read.

**Dependencies:** rspec-core (>= 2, < 4, != 2.12.0)

## [rss](https://github.com/ruby/rss)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Kouhei Sutou |
| **License** | BSD-2-Clause |

Family of libraries that support various formats of XML "feeds".

**Dependencies:** rexml (>= 0)

## [rssable](http://github.com/rubyhero/rssable)

| | |
|---|---|
| **Version** | 0.0.4 |
| **Authors** | Paweł Dąbrowski |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Access the RSS channel of any webiste without worrying about the engine

**Dependencies:** rest-client (~> 2.0, >= 2.0.2), nokogiri (~> 1.8, >= 1.8.2)

## [rswag](https://github.com/rswag/rswag)

| | |
|---|---|
| **Version** | 2.17.0 |
| **Authors** | Richie Morris, Greg Myers, Jay Danielian |
| **License** | MIT |

OpenAPI (formerly named Swagger) tooling for Rails APIs

Generate beautiful API documentation, including a UI to explore and test operations, directly from your rspec integration tests. OpenAPI 2 and 3 supported. More about the OpenAPI initiative here: http://spec.openapis.org/

**Dependencies:** rswag-specs (= 2.17.0), rswag-api (= 2.17.0), rswag-ui (= 2.17.0)

## [rswag-api](https://github.com/rswag/rswag)

| | |
|---|---|
| **Version** | 2.17.0 |
| **Authors** | Richie Morris, Greg Myers, Jay Danielian |
| **License** | MIT |

A Rails Engine that exposes OpenAPI (formerly called Swagger) files as JSON endpoints

Open up your API to the phenomenal OpenAPI ecosystem by exposing OpenAPI files, that describe your service, as JSON endpoints. More about the OpenAPI initiative here: http://spec.openapis.org/

**Dependencies:** activesupport (>= 5.2, < 8.2), railties (>= 5.2, < 8.2)

## [rswag-specs](https://github.com/rswag/rswag)

| | |
|---|---|
| **Version** | 2.17.0 |
| **Authors** | Richie Morris, Greg Myers, Jay Danielian |
| **License** | MIT |

An OpenAPI-based (formerly called Swagger) DSL for rspec-rails & accompanying rake task for generating OpenAPI specification files

Simplify API integration testing with a succinct rspec DSL and generate OpenAPI specification files directly from your rspec tests. More about the OpenAPI initiative here: http://spec.openapis.org/

**Dependencies:** activesupport (>= 5.2, < 8.2), json-schema (>= 2.2, < 7.0), railties (>= 5.2, < 8.2), rspec-core (>= 2.14)

## [rswag-ui](https://github.com/rswag/rswag)

| | |
|---|---|
| **Version** | 2.17.0 |
| **Authors** | Richie Morris, Greg Myers, Jay Danielian |
| **License** | MIT |

A Rails Engine that includes swagger-ui and powers it from configured OpenAPI (formerly named Swagger) endpoints

Expose beautiful API documentation, powered by Swagger JSON endpoints, including a UI to explore and test operations. More about the OpenAPI initiative here: http://spec.openapis.org/

**Dependencies:** actionpack (>= 5.2, < 8.2), railties (>= 5.2, < 8.2)

## [rtesseract](http://github.com/dannnylo/rtesseract)

| | |
|---|---|
| **Version** | 3.1.4 |
| **Authors** | Danilo Jeremias da Silva |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Ruby library for working with the Tesseract OCR.

## [rubocop](https://github.com/rubocop/rubocop)

| | |
|---|---|
| **Version** | 1.82.1 |
| **Authors** | Bozhidar Batsov, Jonas Arvidsson, Yuji Nakayama |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Automatic Ruby code style checking tool.

RuboCop is a Ruby code style checking and code formatting tool. It aims to enforce the community-driven Ruby Style Guide.

**Dependencies:** json (~> 2.3), language_server-protocol (~> 3.17.0.2), lint_roller (~> 1.1.0), parallel (~> 1.10), parser (>= 3.3.0.2), rainbow (>= 2.2.2, < 4.0), regexp_parser (>= 2.9.3, < 3.0), rubocop-ast (>= 1.48.0, < 2.0), ruby-progressbar (~> 1.7), unicode-display_width (>= 2.4.0, < 4.0)

## [rubocop-ast](https://github.com/rubocop/rubocop-ast)

| | |
|---|---|
| **Version** | 1.49.0 |
| **Authors** | Bozhidar Batsov, Jonas Arvidsson, Yuji Nakayama |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

RuboCop tools to deal with Ruby code AST.

RuboCop's Node and NodePattern classes.

**Dependencies:** parser (>= 3.3.7.2), prism (~> 1.7)

## [rubocop-capybara](https://github.com/rubocop/rubocop-capybara)

| | |
|---|---|
| **Version** | 2.22.1 |
| **Authors** | Yudai Takada |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Code style checking for Capybara test files

Code style checking for Capybara test files (RSpec, Cucumber, Minitest). A plugin for the RuboCop code style enforcing & linting tool.

**Dependencies:** lint_roller (~> 1.1), rubocop (~> 1.72, >= 1.72.1)

## [rubocop-factory_bot](https://github.com/rubocop/rubocop-factory_bot)

| | |
|---|---|
| **Version** | 2.28.0 |
| **Authors** | John Backus, Ian MacLeod, Phil Pirozhkov, Maxim Krizhanovsky, Andrew Bromwich |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Code style checking for factory_bot files

Code style checking for factory_bot files. A plugin for the RuboCop code style enforcing & linting tool.

**Dependencies:** lint_roller (~> 1.1), rubocop (~> 1.72, >= 1.72.1)

## [rubocop-minitest](https://rubygems.org/gems/rubocop-minitest)

| | |
|---|---|
| **Version** | 0.38.2 |
| **Authors** | Bozhidar Batsov, Jonas Arvidsson, Koichi ITO |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Automatic Minitest code style checking tool.

Automatic Minitest code style checking tool. A RuboCop extension focused on enforcing Minitest best practices and coding conventions.

**Dependencies:** lint_roller (~> 1.1), rubocop (>= 1.75.0, < 2.0), rubocop-ast (>= 1.38.0, < 2.0)

## [rubocop-obsession](https://github.com/jeromedalbert/rubocop-obsession)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Jerome Dalbert |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

High-level code style checking for Ruby files.

A collection of RuboCop cops for enforcing higher-level code concepts.

**Dependencies:** activesupport (>= 0), lint_roller (~> 1.1), rubocop (~> 1.72)

## [rubocop-performance](https://github.com/rubocop/rubocop-performance)

| | |
|---|---|
| **Version** | 1.26.1 |
| **Authors** | Bozhidar Batsov, Jonas Arvidsson, Yuji Nakayama |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Automatic performance checking tool for Ruby code.

A collection of RuboCop cops to check for performance optimizations in Ruby code.

**Dependencies:** lint_roller (~> 1.1), rubocop (>= 1.75.0, < 2.0), rubocop-ast (>= 1.47.1, < 2.0)

## [rubocop-rails](https://github.com/rubocop/rubocop-rails)

| | |
|---|---|
| **Version** | 2.34.3 |
| **Authors** | Bozhidar Batsov, Jonas Arvidsson, Yuji Nakayama |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Automatic Rails code style checking tool.

Automatic Rails code style checking tool. A RuboCop extension focused on enforcing Rails best practices and coding conventions.

**Dependencies:** activesupport (>= 4.2.0), lint_roller (~> 1.1), rack (>= 1.1), rubocop (>= 1.75.0, < 2.0), rubocop-ast (>= 1.44.0, < 2.0)

## [rubocop-rails-omakase](https://github.com/rails/rubocop-rails-omakase)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |

Omakase Ruby styling for Rails

**Dependencies:** rubocop (>= 1.72), rubocop-rails (>= 2.30), rubocop-performance (>= 1.24)

## [rubocop-rake](https://github.com/rubocop/rubocop-rake)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | Masataka Pocke Kuwabara |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A RuboCop plugin for Rake

**Dependencies:** lint_roller (~> 1.1), rubocop (>= 1.72.1)

## [rubocop-rspec](https://github.com/rubocop/rubocop-rspec)

| | |
|---|---|
| **Version** | 3.9.0 |
| **Authors** | John Backus, Ian MacLeod, Nils Gemeinhardt |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Code style checking for RSpec files

Code style checking for RSpec files. A plugin for the RuboCop code style enforcing & linting tool.

**Dependencies:** lint_roller (~> 1.1), rubocop (~> 1.81)

## [rubocop-rspec_rails](https://github.com/rubocop/rubocop-rspec_rails)

| | |
|---|---|
| **Version** | 2.32.0 |
| **Authors** | Benjamin Quorning, Phil Pirozhkov, Maxim Krizhanovsky, Yudai Takada |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Code style checking for RSpec Rails files

Code style checking for RSpec Rails files. A plugin for the RuboCop code style enforcing & linting tool.

**Dependencies:** lint_roller (~> 1.1), rubocop (~> 1.72, >= 1.72.1), rubocop-rspec (~> 3.5)

## [rubocop-yard](https://github.com/ksss/rubocop-yard)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | ksss |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Check yardoc format.

Check yardoc format like tag type.

**Dependencies:** lint_roller (>= 0), rubocop (~> 1.72), yard (>= 0)

## [ruby-anthropic](https://github.com/alexrudall/ruby-anthropic)

| | |
|---|---|
| **Version** | 0.4.2 |
| **Authors** | Alex |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Anthropic API + Ruby! 🤖🌌

**Dependencies:** event_stream_parser (>= 0.3.0, < 2.0.0), faraday (>= 1), faraday-multipart (>= 1)

## [ruby-enum](http://github.com/dblock/ruby-enum)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Daniel Doubrovkine |
| **License** | MIT |

Enum-like behavior for Ruby.

**Dependencies:** i18n (>= 0)

## [ruby-graphviz](https://github.com/glejeune/Ruby-Graphviz)

| | |
|---|---|
| **Version** | 1.2.5 |
| **Authors** | Gregoire Lejeune |
| **License** | GPL-2.0 |
| **Ruby** | >= 2.4.0 |

Interface to the GraphViz graphing tool

Ruby/Graphviz provides an interface to layout and generate images of directed graphs in a variety of formats (PostScript, PNG, etc.) using GraphViz.

**Dependencies:** rexml (>= 0)

## [ruby-hmac](http://ruby-hmac.rubyforge.org)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Daiki Ueno, Geoffrey Grosenbach |

This module provides common interface to HMAC functionality

This module provides common interface to HMAC functionality. HMAC is a kind of "Message Authentication Code" (MAC) algorithm whose standard is documented in RFC2104. Namely, a MAC provides a way to check the integrity of information transmitted over or stored in an unreliable medium, based on a secret key.  Originally written by Daiki Ueno. Converted to a RubyGem by Geoffrey Grosenbach

## [ruby-libgd](https://github.com/ggerman/ruby-libgd)

| | |
|---|---|
| **Version** | 0.2.4 |
| **Authors** | Germán Alberto Giménez Silva |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Native Ruby bindings for libgd

High-performance native Ruby bindings to libgd for image generation, drawing, filters, alpha blending, and transformations.

## [ruby-lsp](https://github.com/Shopify/ruby-lsp)

| | |
|---|---|
| **Version** | 0.26.5 |
| **Authors** | Shopify |
| **License** | MIT |
| **Ruby** | >= 3.0 |

An opinionated language server for Ruby

**Dependencies:** language_server-protocol (~> 3.17.0), prism (>= 1.2, < 2.0), rbs (>= 3, < 5)

## [ruby-lsp-rails](https://github.com/Shopify/ruby-lsp-rails)

| | |
|---|---|
| **Version** | 0.4.8 |
| **Authors** | Shopify |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A Ruby LSP addon for Rails

A Ruby LSP addon that adds extra editor functionality for Rails applications

**Dependencies:** ruby-lsp (>= 0.26.0, < 0.27.0)

## [ruby-mcp-client](https://github.com/simonx1/ruby-mcp-client)

| | |
|---|---|
| **Version** | 0.9.1 |
| **Authors** | Szymon Kurcab |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A Ruby client for the Model Context Protocol (MCP)

Ruby client library for integrating with Model Context Protocol (MCP) servers to access and invoke tools from AI assistants

**Dependencies:** faraday (~> 2.0), faraday-follow_redirects (~> 0.3), faraday-retry (~> 2.0)

## [ruby-next](https://github.com/ruby-next/ruby-next)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

Make older Rubies quack like edge Ruby

Ruby Next is a collection of polyfills and a transpiler for supporting latest and upcoming edge CRuby features in older versions and alternative implementations (such as mruby, JRuby, Opal, Artichoke, RubyMotion, etc.).

**Dependencies:** ruby-next-core (= 1.2.0), ruby-next-parser (>= 3.4.0.2), require-hooks (~> 0.2), unparser (~> 0.6.0), paco (~> 0.2)

## [ruby-next-core](https://github.com/ruby-next/ruby-next)

| | |
|---|---|
| **Version** | 1.2.0 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

Ruby Next core functionality

Ruby Next Core is a zero deps version of Ruby Next meant to be used as as dependency in your gems.  It contains all the polyfills and utility files but doesn't require transpiler dependencies to be install.

## [ruby-next-parser](http://github.com/ruby-next/parser)

| | |
|---|---|
| **Version** | 3.4.0.2 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Parser extension to support edge and experimental Ruby syntax

**Dependencies:** parser (>= 3.0.3.1)

## [ruby-ole](https://github.com/aquasync/ruby-ole)

| | |
|---|---|
| **Version** | 1.2.13.1 |
| **Authors** | Charles Lowe |
| **License** | MIT |

Ruby OLE library.

A library for easy read/write access to OLE compound documents for Ruby.

## [ruby-openai](https://github.com/alexrudall/ruby-openai)

| | |
|---|---|
| **Version** | 3.4.0 |
| **Authors** | Alex |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A Ruby gem for the OpenAI GPT-3 API

**Dependencies:** httparty (>= 0.18.1)

## [ruby-openai-swarm](https://github.com/graysonchen/ruby-openai-swarm)

| | |
|---|---|
| **Version** | 0.5.3 |
| **Authors** | Grayson Chen |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A Ruby implementation of OpenAI function calling swarm

Allows for creating swarms of AI agents that can call functions and interact with each other

**Dependencies:** ruby-openai (>= 7.3, < 9.0), ostruct (>= 0), activesupport (>= 0)

## [ruby-pg-extras](http://github.com/pawurb/ruby-pg-extras)

| | |
|---|---|
| **Version** | 5.6.16 |
| **Authors** | pawurb |
| **License** | MIT |

Ruby PostgreSQL performance database insights

Ruby port of Heroku PG Extras. The goal of this project is to provide a powerful insights into PostgreSQL database for Ruby on Rails apps that are not using the default Heroku PostgreSQL plugin.

**Dependencies:** pg (>= 0), terminal-table (>= 0)

## [ruby-progressbar](https://github.com/jfelchner/ruby-progressbar)

| | |
|---|---|
| **Version** | 1.13.0 |
| **Authors** | thekompanee, jfelchner |
| **License** | MIT |

Ruby/ProgressBar is a flexible text progress bar library for Ruby.

Ruby/ProgressBar is an extremely flexible text progress bar library for Ruby. The output can be customized with a flexible formatting system including: percentage, bars of various formats, elapsed time and estimated time remaining.

## [ruby-rc4](http://www.caigenichols.com/)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | Caige Nichols |

RubyRC4 is a pure Ruby implementation of the RC4 algorithm.

## [ruby-shell](https://isene.com/)

| | |
|---|---|
| **Version** | 3.6.10 |
| **Authors** | Geir Isene |
| **License** | Unlicense |

rsh - Ruby SHell

A shell written in Ruby with extensive tab completions, aliases/nicks, history, syntax highlighting, theming, auto-cd, auto-opening files and more. UPDATE v3.6.10: OSC 7 support - reports cwd to terminal for wezterm/kitty spawn-in-same-dir.

## [ruby-statistics](https://github.com/estebanz01/ruby-statistics)

| | |
|---|---|
| **Version** | 4.1.0 |
| **Authors** | esteban zapata |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A ruby gem for som specific statistics. Inspired by the jStat js library.

This gem is intended to accomplish the same purpose as jStat js library: to provide ruby with statistical capabilities without the need of a statistical programming language like R or Octave. Some functions and capabilities are an implementation from other authors and are referenced properly in the class/method.

## [ruby-stemmer](http://github.com/aurelian/ruby-stemmer)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Aurelian Oancea, Yury Korolev |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Expose libstemmer_c to Ruby.

Expose the bundled libstemmer_c library to Ruby.

## [ruby-units](https://github.com/olbrich/ruby-units)

| | |
|---|---|
| **Version** | 4.1.0 |
| **Authors** | Kevin Olbrich |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Provides classes and methods to perform unit math and conversions

## [ruby-vips](http://github.com/libvips/ruby-vips)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | John Cupitt |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A fast image processing library with low memory needs

ruby-vips is a binding for the libvips image processing library. It is fast and it can process large images without loading the whole image in memory.

**Dependencies:** ffi (~> 1.12), logger (>= 0)

## [ruby-xxHash](https://github.com/justinwsmith/ruby-xxhash)

| | |
|---|---|
| **Version** | 0.4.0.2 |
| **Authors** | Justin W Smith |
| **License** | MIT |

A pure Ruby implementation of xxhash.

## [ruby2_keywords](https://github.com/ruby/ruby2_keywords)

| | |
|---|---|
| **Version** | 0.0.5 |
| **Authors** | Nobuyoshi Nakada |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.0.0 |

Shim library for Module#ruby2_keywords

## [ruby2js](http://github.com/rubys/ruby2js)

| | |
|---|---|
| **Version** | 5.1.2 |
| **Authors** | Sam Ruby, Jared White |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Minimal yet extensible Ruby to JavaScript conversion.

The base package maps Ruby syntax to JavaScript semantics. Filters may be provided to add Ruby-specific or framework specific behavior.

**Dependencies:** parser (>= 0), regexp_parser (~> 2.1.1)

## [ruby2ruby](https://github.com/seattlerb/ruby2ruby)

| | |
|---|---|
| **Version** | 2.6.1 |
| **Authors** | Ryan Davis |
| **License** | MIT |
| **Ruby** | >= 3.2 |

ruby2ruby provides a means of generating pure ruby code easily from RubyParser compatible Sexps

ruby2ruby provides a means of generating pure ruby code easily from RubyParser compatible Sexps. This makes making dynamic language processors in ruby easier than ever!

**Dependencies:** sexp_processor (~> 4.6)

## [ruby_engine](https://github.com/janlelis/ruby_engine)

| | |
|---|---|
| **Version** | 2.0.3 |
| **Authors** | Jan Lelis |
| **License** | MIT |

Adds the RubyEngine pseudo-constant.

Gives you an RubyEngine class that simplifies checking for your Ruby implementation.

## [ruby_info](https://github.com/janlelis/ruby_info)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Jan Lelis |
| **License** | MIT |

Adds the RubyInfo pseudo-constant.

Provides a RubyInfo class that simplifies accessing global information. Run RubyInfo.list to get started.

## [ruby_llm](https://rubyllm.com)

| | |
|---|---|
| **Version** | 1.8.2 |
| **Authors** | Carmine Paolino |
| **License** | MIT |
| **Ruby** | >= 3.1.3 |

One beautiful Ruby API for GPT, Claude, Gemini, and more.

One beautiful Ruby API for GPT, Claude, Gemini, and more. Easily build chatbots, AI agents, RAG applications, and content generators. Features chat (text, images, audio, PDFs), image generation, embeddings, tools (function calling), structured output, Rails integration, and streaming. Works with OpenAI, Anthropic, Google Gemini, AWS Bedrock, DeepSeek, Mistral, Ollama (local models), OpenRouter, Perplexity, GPUStack, and any OpenAI-compatible API. Minimal dependencies - just Faraday, Zeitwerk, and Marcel.

**Dependencies:** base64 (>= 0), event_stream_parser (~> 1), faraday (>= 1.10.0), faraday-multipart (>= 1), faraday-net_http (>= 1), faraday-retry (>= 1), marcel (~> 1.0), zeitwerk (~> 2)

## [ruby_llm-agents](https://github.com/adham90/ruby_llm-agents)

| | |
|---|---|
| **Version** | 1.3.4 |
| **Authors** | adham90 |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Agent framework for building LLM-powered agents with RubyLLM

A Rails engine for creating, managing, and monitoring LLM-powered agents. Includes a DSL for agent configuration, execution tracking, cost analytics, and a mountable dashboard UI.

**Dependencies:** rails (>= 7.0), ruby_llm (>= 1.11.0), csv (>= 0), ostruct (>= 0)

## [ruby_llm-docker](https://github.com/afstanton/ruby_llm-docker)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Aaron F Stanton |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Docker management tools for RubyLLM - comprehensive container, image, network, and volume operations

A comprehensive Ruby gem that provides Docker management capabilities through RubyLLM tools. Enables AI assistants to interact with Docker containers, images, networks, and volumes using natural language. Ported from DockerMCP to work directly with RubyLLM without requiring an external MCP server.

**Dependencies:** base64 (>= 0), docker-api (>= 0), ruby_llm (>= 0), tool_forge (>= 0), zeitwerk (>= 0)

## [ruby_llm-instrumentation](https://github.com/sinaptia/ruby_llm-instrumentation)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Patricio Mac Adden |

Rails instrumentation for RubyLLM

**Dependencies:** rails (>= 7.2.0), ruby_llm (>= 0)

## [ruby_llm-mcp](https://www.rubyllm-mcp.com)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Patrick Vice |
| **License** | MIT |
| **Ruby** | >= 3.1.3 |

A RubyLLM MCP Client

A Ruby client for the Model Context Protocol (MCP) that seamlessly integrates with RubyLLM. Connect to MCP servers via SSE or stdio transports, automatically convert MCP tools into RubyLLM-compatible tools, and enable AI models to interact with external data sources and services. Makes using MCP with RubyLLM as easy as possible.

**Dependencies:** httpx (~> 1.4), json-schema (~> 5.0), ruby_llm (~> 1.9), zeitwerk (~> 2)

## [ruby_llm-monitoring](https://github.com/sinaptia/ruby_llm-monitoring)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Patricio Mac Adden |

Monitoring engine for RubyLLM

**Dependencies:** groupdate (>= 0), importmap-rails (>= 0), rails (>= 7.0.0), ruby_llm (>= 0), ruby_llm-instrumentation (>= 0.1), stimulus-rails (>= 0), turbo-rails (>= 0)

## [ruby_llm-responses_api](https://github.com/khasinski/ruby_llm-responses_api)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Chris Hasinski |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

OpenAI Responses API provider for RubyLLM

A RubyLLM provider that implements OpenAI's Responses API, providing access to built-in tools (web search, code interpreter, file search), stateful conversations, background mode, and MCP support.

**Dependencies:** ruby_llm (>= 1.0)

## [ruby_llm-schema](https://github.com/danielfriis/ruby_llm-schema)

| | |
|---|---|
| **Version** | 0.2.5 |
| **Authors** | Daniel Friis |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A simple and clean Ruby DSL for creating JSON schemas.

## [ruby_llm-semantic_cache](https://github.com/khasinski/ruby_llm-semantic_cache)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Chris Hasinski |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Semantic caching for RubyLLM applications

Cache RubyLLM responses based on semantic similarity, not exact string matching. Reduces costs and latency by returning cached responses for semantically equivalent queries.

**Dependencies:** ruby_llm (~> 1.0)

## [ruby_llm-skills](https://github.com/kieranklaassen/ruby_llm-skills)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Kieran Klaassen |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Agent Skills extension for RubyLLM

Load, validate, and integrate Agent Skills with RubyLLM. Supports the open Agent Skills specification for progressive skill discovery and loading from filesystem, zip archives, and databases.

**Dependencies:** ruby_llm (>= 1.10)

## [ruby_llm-template](https://github.com/danielfriis/ruby_llm-template)

| | |
|---|---|
| **Version** | 0.1.6 |
| **Authors** | Daniel Friis |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Template management system for RubyLLM - organize and reuse ERB templates for AI chat interactions

RubyLLM::Template provides a flexible template system for RubyLLM, allowing you to organize chat prompts, system messages, and schemas in ERB template files for easy reuse and maintenance.

**Dependencies:** ruby_llm (>= 1.0), ruby_llm-schema (>= 0.2.0)

## [ruby_llm_swarm](https://github.com/parruda/ruby_llm)

| | |
|---|---|
| **Version** | 1.9.7 |
| **Authors** | Paulo Arruda |
| **License** | MIT |
| **Ruby** | >= 3.1.3 |

Fork of RubyLLM with features to power Swarm, a multi-agent orchestration framework.

Fork of RubyLLM with features to power Swarm, a multi-agent orchestration framework. One beautiful Ruby API for GPT, Claude, Gemini, and more. Easily build chatbots, AI agents, RAG applications, and content generators. Features chat (text, images, audio, PDFs), image generation, embeddings, tools (function calling), structured output, Rails integration, and streaming. Works with OpenAI, Anthropic, Google Gemini, AWS Bedrock, DeepSeek, Mistral, Ollama (local models), OpenRouter, Perplexity, GPUStack, and any OpenAI-compatible API. Minimal dependencies - just Faraday, Zeitwerk, and Marcel.

**Dependencies:** async-http-faraday (~> 0.22), base64 (>= 0), event_stream_parser (~> 1), faraday (>= 1.10.0), faraday-multipart (>= 1), faraday-net_http (>= 1), faraday-retry (>= 1), marcel (~> 1.0), openssl (~> 3.3.2), ruby_llm-schema (~> 0.2.1), zeitwerk (~> 2)

## [ruby_llm_swarm-mcp](https://www.rubyllm-mcp.com)

| | |
|---|---|
| **Version** | 0.8.2 |
| **Authors** | Patrick Vice |
| **License** | MIT |
| **Ruby** | >= 3.1.3 |

A RubyLLM MCP Client

A Ruby client for the Model Context Protocol (MCP) that seamlessly integrates with RubyLLM. Connect to MCP servers via SSE or stdio transports, automatically convert MCP tools into RubyLLM-compatible tools, and enable AI models to interact with external data sources and services. Makes using MCP with RubyLLM as easy as possible.

**Dependencies:** httpx (~> 1.4), json-schema (~> 5.0), zeitwerk (~> 2)

## [ruby_parser](https://github.com/seattlerb/ruby_parser)

| | |
|---|---|
| **Version** | 3.22.0 |
| **Authors** | Ryan Davis |
| **License** | MIT |
| **Ruby** | >= 3.2 |

ruby_parser (RP) is a ruby parser written in pure ruby (utilizing racc--which does by default use a C extension)

ruby_parser (RP) is a ruby parser written in pure ruby (utilizing racc--which does by default use a C extension). It outputs s-expressions which can be manipulated and converted back to ruby via the ruby2ruby gem.  As an example:  def conditional1 arg1 return 1 if arg1 == 0 return 0 end  becomes:  s(:defn, :conditional1, s(:args, :arg1), s(:if, s(:call, s(:lvar, :arg1), :==, s(:lit, 0)), s(:return, s(:lit, 1)), nil), s(:return, s(:lit, 0)))  Tested against 801,039 files from the latest of all rubygems (as of 2013-05):  * 1.8 parser is at 99.9739% accuracy, 3.651 sigma * 1.9 parser is at 99.9940% accuracy, 4.013 sigma * 2.0 parser is at 99.9939% accuracy, 4.008 sigma * 2.6 parser is at 99.9972% accuracy, 4.191 sigma * 3.0 parser has a 100% parse rate. * Tested against 2,672,412 unique ruby files across 167k gems. * As do all the others now, basically.

**Dependencies:** sexp_processor (~> 4.16), racc (~> 1.5)

## [ruby_ui](https://rubygems.org/gems/ruby_ui)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | George Kettle |
| **License** | MIT |
| **Ruby** | >= 3.2 |

RubyUI is a UI Component Library for Ruby developers.

Ruby UI is a UI Component Library for Ruby developers. Built on top of the Phlex Framework.

## [ruby_version](https://github.com/janlelis/ruby_version)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Jan Lelis |
| **License** | MIT |

Adds the RubyVersion pseudo-constant.

Provides a RubyVersion class which offers a convenient DSL for checking for the right Ruby version

## [rubyai](https://github.com/alexshapalov/rubyai)

| | |
|---|---|
| **Version** | 0.5 |
| **Authors** | Alex Shapalov |
| **License** | MIT |
| **Ruby** | >= 2.6 |

A Ruby gem for the OpenAI (GPT-4) API

RubyAI is a wrapper for the OpenAI API that allows you to interact with GPT-4 within Ruby/Rails applications. It provides simple methods for integrating language model capabilities into your Ruby projects.

**Dependencies:** faraday (~> 2.0), faraday-net_http_persistent (>= 0)

## [rubycritic](https://github.com/whitesmith/rubycritic)

| | |
|---|---|
| **Version** | 5.0.0 |
| **Authors** | Guilherme Simoes |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

RubyCritic is a Ruby code quality reporter

RubyCritic is a tool that wraps around various static analysis gems to provide a quality report of your Ruby code.

**Dependencies:** flay (~> 2.13), flog (~> 4.7), launchy (>= 2.5.2), ostruct (>= 0), parser (>= 3.3.0.5), prism (>= 1.6.0), rainbow (~> 3.1.1), reek (~> 6.5.0, < 7.0), rexml (>= 0), ruby_parser (~> 3.21), simplecov (>= 0.22.0), tty-which (~> 0.5.0), virtus (~> 2.0)

## [rubyfmt](https://rubygems.org/gems/rubyfmt)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Wojtek Mach |
| **License** | MIT |

Ruby port of gofmt

**Dependencies:** ruby2ruby (~> 2.0)

## [rubygems-tasks](https://github.com/postmodern/rubygems-tasks#readme)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Postmodern |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Rake tasks for building and releasing Ruby Gems.

rubygems-tasks provides agnostic and unobtrusive Rake tasks for building and releasing Ruby Gems. rubygems-tasks can be used in any existing Ruby project that has a .gemspec file.

**Dependencies:** rake (>= 10.0.0), irb (~> 1.0)

## [rubygems-update](https://guides.rubygems.org)

| | |
|---|---|
| **Version** | 4.0.6 |
| **Authors** | Jim Weirich, Chad Fowler, Eric Hodel, Luis Lavena, Aaron Patterson, Samuel Giddins, André Arko, Evan Phoenix, Hiroshi SHIBATA |
| **License** | Ruby, MIT |
| **Ruby** | >= 3.2.0 |

RubyGems is a package management framework for Ruby. This gem is downloaded and installed by `gem update --system`, so that the `gem` CLI can update itself.

A package (also known as a library) contains a set of functionality that can be invoked by a Ruby program, such as reading and parsing an XML file. We call these packages 'gems' and RubyGems is a tool to install, create, manage and load these packages in your Ruby environment. RubyGems is also a client for RubyGems.org, a public repository of Gems that allows you to publish a Gem that can be shared and used by other developers. See our guide on publishing a Gem at guides.rubygems.org

## [rubyllm-semantic_router](https://github.com/khasinski/ruby_llm-semantic_router)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Chris Hasiński |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Semantic routing for RubyLLM multi-agent systems

Route messages to specialized RubyLLM chat agents based on semantic similarity using embeddings and kNN lookup

**Dependencies:** ruby_llm (~> 1.0)

## [rubyntlm](https://github.com/winrb/rubyntlm)

| | |
|---|---|
| **Version** | 0.6.5 |
| **Authors** | Kohei Kajimoto, Paul Morton |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Ruby/NTLM library.

Ruby/NTLM provides message creator and parser for the NTLM authentication.

**Dependencies:** base64 (>= 0)

## [rubyshell](https://github.com/albertalef/rubyshell)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | albertalef |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A rubist way to run shell commands

## [rubysmith](https://alchemists.io/projects/rubysmith)

| | |
|---|---|
| **Version** | 9.1.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 4.0 |

A command line interface for smithing Ruby projects.

**Dependencies:** cogger (~> 2.0), containable (~> 2.0), dry-monads (~> 1.9), dry-schema (~> 1.15), etcher (~> 4.0), gitt (~> 5.0), infusible (~> 5.0), pragmater (~> 17.0), refinements (~> 14.0), rubocop (~> 1.82), runcom (~> 13.0), sod (~> 2.0), spek (~> 5.0), tocer (~> 20.0), tone (~> 3.0), zeitwerk (~> 2.7)

## [rubytoolbox-api](https://www.ruby-toolbox.com)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Christoph Olszowka |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

A simple, dependency-free API client for The Ruby Toolbox

## [rubyzip](http://github.com/rubyzip/rubyzip)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Alexander Simonov |
| **License** | BSD 2-Clause |
| **Ruby** | >= 1.9.2 |

rubyzip is a ruby module for reading and writing zip files

## [rufo](https://github.com/ruby-formatter/rufo)

| | |
|---|---|
| **Version** | 0.18.2 |
| **Authors** | Ary Borenszweig |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby code formatter

Fast and unobtrusive Ruby code formatter

## [rufus-scheduler](https://github.com/jmettraux/rufus-scheduler)

| | |
|---|---|
| **Version** | 3.9.2 |
| **Authors** | John Mettraux |
| **License** | MIT |
| **Ruby** | >= 1.9 |

job scheduler for Ruby (at, cron, in and every jobs)

Job scheduler for Ruby (at, cron, in and every jobs). Not a replacement for crond.

**Dependencies:** fugit (~> 1.1, >= 1.11.1)

## [rugal](https://rubygems.org/gems/rugal)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Simone Scalabrino |
| **License** | GPL-2.0 |

Genetic algorithms for ruby

Pure-ruby implementation of genetic algorithms

## [rugged](https://github.com/libgit2/rugged)

| | |
|---|---|
| **Version** | 1.9.0 |
| **Authors** | Scott Chacon, Vicent Marti |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Rugged is a Ruby binding to the libgit2 linkable library

Rugged is a Ruby bindings to the libgit2 linkable C Git library. This is for testing and using the libgit2 library in a language that is awesome.

## [rumale](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale is a machine learning library in Ruby. Rumale supports Support Vector Machine, Logistic Regression, Multi-layer Perceptron, Naive Bayes, Decision Tree, Random Forest, K-Means, Gaussian Mixture Model, DBSCAN, Principal Component Analysis, and many other algorithms.

Rumale is a machine learning library in Ruby. Rumale provides machine learning algorithms with interfaces similar to Scikit-Learn in Python. Rumale supports Support Vector Machine, Logistic Regression, Ridge, Lasso, Multi-layer Perceptron, Naive Bayes, Decision Tree, Gradient Tree Boosting, Random Forest, K-Means, Gaussian Mixture Model, DBSCAN, Spectral Clustering, Mutidimensional Scaling, t-SNE, Fisher Discriminant Analysis, Neighbourhood Component Analysis, Principal Component Analysis, Non-negative Matrix Factorization, and many other algorithms.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-clustering (~> 2.0.2), rumale-core (~> 2.0.2), rumale-decomposition (~> 2.0.2), rumale-ensemble (~> 2.0.2), rumale-evaluation_measure (~> 2.0.2), rumale-feature_extraction (~> 2.0.2), rumale-kernel_approximation (~> 2.0.2), rumale-kernel_machine (~> 2.0.2), rumale-linear_model (~> 2.0.2), rumale-manifold (~> 2.0.2), rumale-metric_learning (~> 2.0.2), rumale-model_selection (~> 2.0.2), rumale-naive_bayes (~> 2.0.2), rumale-nearest_neighbors (~> 2.0.2), rumale-neural_network (~> 2.0.2), rumale-pipeline (~> 2.0.2), rumale-preprocessing (~> 2.0.2), rumale-tree (~> 2.0.2)

## [rumale-clustering](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Clustering provides cluster analysis algorithms with Rumale interface.

Rumale::Clustering provides cluster analysis algorithms, such as K-Means, Gaussian Mixture Model, DBSCAN, and Spectral Clustering, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-core](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Core provides base classes and utility functions for implementing machine learning algorithm with Rumale interface.

Rumale::Core provides base classes and utility functions for implementing machine learning algorithm with Rumale interface.

**Dependencies:** csv (>= 3.1.9), numo-narray-alt (~> 0.9.10)

## [rumale-decomposition](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Decomposition provides matrix decomposition algorithms with Rumale interface

Rumale::Decomposition provides matrix decomposition algorithms, such as Principal Component Analysis, Non-negative Matrix Factorization, Factor Analysis, and Independent Component Analysis, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-ensemble](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Ensemble provides ensemble learning algorithms with Rumale interface.

Rumale::Ensemble provides ensemble learning algorithms, such as AdaBoost, Gradient Tree Boosting, and Random Forest, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2), rumale-linear_model (~> 2.0.2), rumale-model_selection (~> 2.0.2), rumale-preprocessing (~> 2.0.2), rumale-tree (~> 2.0.2)

## [rumale-evaluation_measure](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::EvaluationMeasure provides evaluation measures with Rumale interface.

Rumale::EvaluationMeasure provides evaluation measures, such as accuracy, precision, recall, and f-score, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-feature_extraction](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::FeatureExtraction provides feature extraction methods with Rumale interface.

Rumale::FeatureExtraction provides feature extraction methods, such as TF-IDF and feature hashing, with Rumale interface.

**Dependencies:** mmh3 (~> 1.0), numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-kernel_approximation](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::KernelApproximation provides kernel approximation algorithms with Rumale interface.

Rumale::KernelApproximation provides kernel approximation algorithms, such as RBF feature mapping and Nystroem method, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-kernel_machine](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::KernelMachine provides kernel method-based algorithms with Rumale interface.

Rumale::KernelMachine provides kernel method-based algorithms, such as Kernel Support Vector Machine, Kernel Principal Componenet Analysis, and Kernel Ridge Regression, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-linear_model](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::LinearModel provides linear model algorithms with Rumale interface.

Rumale::LinearModel provides linear model algorithms, such as Logistic Regression, Support Vector Machine, Lasso, and Ridge Regression with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), numo-optimize (~> 0.2.2), rumale-core (~> 2.0.2)

## [rumale-manifold](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Manifold provides data embedding algorithms with Rumale interface.

Rumale::Manifold provides data embedding algorithms, such as Multi-dimensional Scaling, Locally Linear Embedding, Laplacian Eigenmaps, Hessian Eigenmaps, and t-distributed Stochastic Neighbor Embedding, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2), rumale-decomposition (~> 2.0.2)

## [rumale-metric_learning](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::MetricLearning provides metric learning algorithms with Rumale interface.

Rumale::MetricLearning provides metric learning algorithms, such as Fisher Discriminant Analysis and Neighboourhood Component Analysis with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), numo-optimize (~> 0.2.2), rumale-core (~> 2.0.2), rumale-decomposition (~> 2.0.2)

## [rumale-model_selection](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::ModelSelection provides model validation techniques with Rumale interface.

Rumale::ModelSelection provides model validation techniques, such as k-fold cross-validation, time series cross-validation, and grid search, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2), rumale-evaluation_measure (~> 2.0.2), rumale-preprocessing (~> 2.0.2)

## [rumale-naive_bayes](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::NaiveBayes provides naive bayes models with Rumale interface.

Rumale::NaiveBayes provides naive bayes models, such as Gaussian Naive Bayes, Multinomial Naive Bayes, and Bernoulli Naive Bayes, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-nearest_neighbors](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::NearestNeighbors provides classifier and regression based on nearest neighbors rule with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-neural_network](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::NeuralNetwork provides classifiers and regression algorithms based on multi-layer perceptron, radial basis function network, and random vector functional link network in the Rumale interface.

Rumale::NeuralNetwork provides classifiers and regression algorithms based on multi-layer perceptron, radial basis function network, and random vector functional link network in the Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-pipeline](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Pipeline provides classes for chaining transformers and estimators with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-preprocessing](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Preprocessing provides preprocessing techniques with Rumale interface.

Rumale::Preprocessing provides preprocessing techniques, such as L2 normalization, standard scaling, and one-hot encoding, with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [rumale-tree](https://github.com/yoshoku/rumale)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | yoshoku |
| **License** | BSD-3-Clause |

Rumale::Tree provides classifier and regression based on decision tree algorithms with Rumale interface.

**Dependencies:** numo-narray-alt (~> 0.9.10), rumale-core (~> 2.0.2)

## [runcom](https://alchemists.io/projects/runcom)

| | |
|---|---|
| **Version** | 12.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A XDG enhanced run command manager for command line interfaces.

**Dependencies:** refinements (~> 13.6), xdg (~> 9.5), zeitwerk (~> 2.7)

## [rupkl](https://github.com/taichi-ishitani/rupkl)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Taichi Ishitani |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Pkl parser for Ruby

**Dependencies:** base64 (>= 0), parslet (>= 2.0.0), regexp_parser (>= 2.9.2)

## [safe_yaml](https://github.com/dtao/safe_yaml)

| | |
|---|---|
| **Version** | 1.0.5 |
| **Authors** | Dan Tao |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

SameYAML provides an alternative implementation of YAML.load suitable for accepting user input in Ruby applications.

Parse YAML safely

## [safely_block](https://github.com/ankane/safely)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Rescue and report exceptions in non-critical code

## [sail](https://github.com/vinistock/sail)

| | |
|---|---|
| **Version** | 3.6.1 |
| **Authors** | Vinicius Stock |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Sail is a lightweight Rails engine that brings an admin panel for managing configuration settings on a live Rails app.

**Dependencies:** fugit (>= 0), rails (>= 5.0.0)

## [samovar](https://github.com/ioquatix/samovar)

| | |
|---|---|
| **Version** | 2.4.1 |
| **Authors** | Samuel Williams, Gabriel Mazetto |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Samovar is a flexible option parser excellent support for sub-commands and help documentation.

**Dependencies:** console (~> 1.0), mapping (~> 1.0)

## [sanitize](https://github.com/rgrove/sanitize/)

| | |
|---|---|
| **Version** | 7.0.0 |
| **Authors** | Ryan Grove |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Allowlist-based HTML and CSS sanitizer.

Sanitize is an allowlist-based HTML and CSS sanitizer. It removes all HTML and/or CSS from a string except the elements, attributes, and properties you choose to allow.'

**Dependencies:** crass (~> 1.0.2), nokogiri (>= 1.16.8)

## [sass](https://sass-lang.com/)

| | |
|---|---|
| **Version** | 3.7.4 |
| **Authors** | Natalie Weizenbaum, Chris Eppstein, Hampton Catlin |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A powerful but elegant CSS compiler that makes CSS fun again.

Ruby Sass is deprecated! See https://sass-lang.com/ruby-sass for details.  Sass makes CSS fun again. Sass is an extension of CSS, adding nested rules, variables, mixins, selector inheritance, and more. It's translated to well-formatted, standard CSS using the command line tool or a web-framework plugin.

**Dependencies:** sass-listen (~> 4.0.0)

## [sass-embedded](https://github.com/sass-contrib/sass-embedded-host-ruby)

| | |
|---|---|
| **Version** | 1.97.3 |
| **Authors** | なつき |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Use dart-sass with Ruby!

A Ruby library that will communicate with Embedded Dart Sass using the Embedded Sass protocol.

**Dependencies:** google-protobuf (~> 4.31)

## [sass-listen](https://github.com/sass/listen)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Thibaud Guillaume-Gentil |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Fork of guard/listen

This fork of guard/listen provides a stable API for users of the ruby Sass CLI

**Dependencies:** rb-fsevent (~> 0.9, >= 0.9.4), rb-inotify (~> 0.9, >= 0.9.7)

## [sassc](https://github.com/sass/sassc-ruby)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Ryan Boland |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Use libsass with Ruby!

**Dependencies:** ffi (~> 1.9)

## [sassc-rails](https://github.com/sass/sassc-rails)

| | |
|---|---|
| **Version** | 2.1.2 |
| **Authors** | Ryan Boland |
| **License** | MIT |

Integrate SassC-Ruby into Rails.

**Dependencies:** sassc (>= 2.0), tilt (>= 0), railties (>= 4.0.0), sprockets (> 3.0), sprockets-rails (>= 0)

## [savon](http://savonrb.com)

| | |
|---|---|
| **Version** | 2.15.1 |
| **Authors** | Daniel Harrington |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Heavy metal SOAP client

**Dependencies:** nori (~> 2.4), httpi (>= 4, < 5), wasabi (>= 3.7, < 6), akami (~> 1.2), gyoku (~> 1.2), builder (>= 2.1.2), nokogiri (>= 1.8.1), mail (~> 2.5)

## [sawyer](https://github.com/lostisland/sawyer)

| | |
|---|---|
| **Version** | 0.9.3 |
| **Authors** | Rick Olson, Wynn Netherland |
| **License** | MIT |

Secret User Agent of HTTP

**Dependencies:** faraday (>= 0.17.3, < 3), addressable (>= 2.3.5)

## [sax-machine](http://github.com/pauldix/sax-machine)

| | |
|---|---|
| **Version** | 1.3.2 |
| **Authors** | Paul Dix, Julien Kirch, Ezekiel Templin, Dmitry Krasnoukhov |
| **License** | MIT |

Declarative SAX Parsing with Nokogiri, Ox or Oga

## [scenic](https://github.com/scenic-views/scenic)

| | |
|---|---|
| **Version** | 1.9.0 |
| **Authors** | Derek Prior, Caleb Hearth |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Support for database views in Rails migrations

Adds methods to ActiveRecord::Migration to create and manage database views in Rails

**Dependencies:** activerecord (>= 4.0.0), railties (>= 4.0.0)

## [screen-recorder](http://github.com/kapoorlakshya/screen-recorder)

| | |
|---|---|
| **Version** | 1.7.0 |
| **Authors** | Lakshya Kapoor |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Video record and take screenshots your computer screen using FFmpeg.

A Ruby gem to video record and take screenshots of your desktop or  specific application window. Works on Windows, Linux, and macOS.

**Dependencies:** streamio-ffmpeg (~> 3.0)

## [search_ui](https://github.com/flori/search_ui)

| | |
|---|---|
| **Version** | 0.0.9 |
| **Authors** | Florian Frank |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Library to provide a user interface for searching in a console

This library allows a user to search an array of objects interactively in the console by matching the pattern a user inputs to an array of objects and pick one of the remaining objects.

**Dependencies:** tins (~> 1.0), term-ansicolor (~> 1.0), amatch (~> 0.0)

## [searchkick](https://github.com/ankane/searchkick)

| | |
|---|---|
| **Version** | 6.0.3 |
| **Authors** | Andrew Kane |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Intelligent search made easy with Rails and Elasticsearch or OpenSearch

**Dependencies:** activemodel (>= 7.2)

## [securerandom](https://github.com/ruby/securerandom)

| | |
|---|---|
| **Version** | 0.4.1 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.1.0 |

Interface for secure random number generator.

## [selenium-webdriver](https://selenium.dev)

| | |
|---|---|
| **Version** | 4.10.0 |
| **Authors** | Alex Rodionov, Titus Fortner, Thomas Walpole |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0 |

Selenium is a browser automation tool for automated testing of webapps and more

Selenium implements the W3C WebDriver protocol to automate popular browsers. It aims to mimic the behaviour of a real user as it interacts with the application's HTML. It's primarily intended for web application testing, but any web-based task can automated.

**Dependencies:** rexml (~> 3.2, >= 3.2.5), rubyzip (>= 1.2.2, < 3.0), websocket (~> 1.0)

## [self_agency](https://github.com/madbomber/self_agency)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

LLM-powered runtime method generation for Ruby classes

A mixin that gives any Ruby class the ability to generate and install methods at runtime via an LLM. Describe what you want in plain English and get a working method back.

**Dependencies:** method_source (>= 0), ruby_llm (>= 0), ruby_llm-template (>= 0)

## [selma](https://rubygems.org/gems/selma)

| | |
|---|---|
| **Version** | 0.4.15 |
| **Authors** | Garen J. Torikian |
| **License** | MIT |
| **Ruby** | >= 3.2, < 4.1.dev |

Selma selects and matches HTML nodes using CSS rules. Backed by Rust's lol_html parser.

## [sem_version](https://github.com/canton7/sem_version)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Antony Male |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

SemVersion: Semantic version parsing and comparison, and constraint checking. See http://semver.org/

Semantic Version parsing, comparison, and constraint checking utility (e.g. ~> 1.2), as specified by http://semver.org/

## [semantic](https://github.com/jlindsey/semantic)

| | |
|---|---|
| **Version** | 1.6.1 |
| **Authors** | Josh Lindsey |
| **License** | MIT |

Semantic Version utility class

Semantic Version utility class for parsing, storing, and comparing versions. See: http://semver.org

## [semantic_logger](https://logger.rocketjob.io)

| | |
|---|---|
| **Version** | 4.17.0 |
| **Authors** | Reid Morrison |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.7 |

Feature rich logging framework, and replacement for existing Ruby & Rails loggers.

**Dependencies:** concurrent-ruby (~> 1.0)

## [semian](https://github.com/shopify/semian)

| | |
|---|---|
| **Version** | 0.27.0 |
| **Authors** | Scott Francis, Simon Eskildsen, Dale Hamel |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Bulkheading for Ruby with SysV semaphores

A Ruby C extention that is used to control access to shared resources across process boundaries with SysV semaphores.

**Dependencies:** concurrent-ruby (>= 0)

## [semian-postgres](https://github.com/mschoenlaub/semian-postgres)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Manuel Schönlaub |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Semian adapter for Postgres

**Dependencies:** concurrent-ruby (>= 0), pg (>= 1.5.0, < 1.7.0), semian (>= 0.16.0, < 1.0.0)

## [sentry-rails](https://github.com/getsentry/sentry-ruby/tree/6.3.0/sentry-rails)

| | |
|---|---|
| **Version** | 6.3.0 |
| **Authors** | Sentry Team |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A gem that provides Rails integration for the Sentry error logger

**Dependencies:** railties (>= 5.2.0), sentry-ruby (~> 6.3.0)

## [sentry-ruby](https://github.com/getsentry/sentry-ruby/tree/6.3.0/sentry-ruby)

| | |
|---|---|
| **Version** | 6.3.0 |
| **Authors** | Sentry Team |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A gem that provides a client interface for the Sentry error logger

**Dependencies:** concurrent-ruby (~> 1.0, >= 1.0.2), bigdecimal (>= 0)

## [sentry-sidekiq](https://github.com/getsentry/sentry-ruby/tree/6.3.0/sentry-sidekiq)

| | |
|---|---|
| **Version** | 6.3.0 |
| **Authors** | Sentry Team |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A gem that provides Sidekiq integration for the Sentry error logger

**Dependencies:** sentry-ruby (~> 6.3.0), sidekiq (>= 5.0)

## [sequel](https://sequel.jeremyevans.net)

| | |
|---|---|
| **Version** | 5.100.0 |
| **Authors** | Jeremy Evans |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

The Database Toolkit for Ruby

**Dependencies:** bigdecimal (>= 0)

## [sequel_pg](http://github.com/jeremyevans/sequel_pg)

| | |
|---|---|
| **Version** | 1.18.2 |
| **Authors** | Jeremy Evans |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Faster SELECTs when using Sequel with pg

sequel_pg overwrites the inner loop of the Sequel postgres adapter row fetching code with a C version.  The C version is significantly faster than the pure ruby version that Sequel uses by default.  sequel_pg also offers optimized versions of some dataset methods, as well as adds support for using PostgreSQL streaming.

**Dependencies:** pg (>= 0.18.0, != 1.2.0), sequel (>= 4.38.0)

## [serbea](https://codeberg.org/jaredwhite/serbea)

| | |
|---|---|
| **Version** | 2.4.1 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Similar to ERB, Except Awesomer

**Dependencies:** erubi (>= 1.13), tilt (>= 2.6)

## [service_actor](https://github.com/sunny/actor)

| | |
|---|---|
| **Version** | 5.0.0 |
| **Authors** | Sunny Ripert |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Service objects for your application logic

**Dependencies:** zeitwerk (>= 1.0)

## [service_actor-promptable](https://github.com/pboling/service_actor-promptable)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Peter Boling |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

TTY Prompt plugin for service_actor

TTY Prompt plugin for your service objects for your application logic

**Dependencies:** service_actor (>= 0), version_gem (~> 1.1)

## [service_actor-rails](https://github.com/sunny/actor-rails)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Sunny Ripert |
| **License** | MIT |

Rails support for Actor

Rails support for the Service Actor gem, helping you create service objects for your application logic.

**Dependencies:** service_actor (>= 0), rails (>= 4.2)

## [serviceworker-rails](https://github.com/rossta/serviceworker-rails)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Ross Kaffenberger |
| **License** | MIT |

ServiceWorker for Rails 3+

Integrates ServiceWorker into the Rails asset pipeline.

**Dependencies:** railties (>= 3.1)

## [serviz](https://github.com/markets/serviz)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | markets |
| **License** | MIT |

Command object Interface for Ruby

## [servolux](http://rubygems.org/gems/servolux)

| | |
|---|---|
| **Version** | 0.13.0 |
| **Authors** | Tim Pease |

A collection of tools for working with processes

Serv-O-Lux is a collection of Ruby classes that are useful for daemon and process management, and for writing your own Ruby services. The code is well documented and tested. It works with Ruby and JRuby supporting 1.9 and 2.0 interpreters.

## [set](https://github.com/ruby/set)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Akinori MUSHA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 3.0.0 |

Provides a class to deal with collections of unordered, unique values

## [sexp_processor](https://github.com/seattlerb/sexp_processor)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Ryan Davis |

sexp_processor branches from ParseTree bringing all the generic sexp processing tools with it

sexp_processor branches from ParseTree bringing all the generic sexp processing tools with it. Sexp, SexpProcessor, Environment, etc... all for your language processing pleasure.

## [sexpr](https://github.com/blambeau/sexp)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Bernard Lambeau |

A compilation framework around s-expressions

Sexpr helps manipulating s-expressions in ruby.

## [shai-cli](https://shaicli.dev)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Sebastian Jimenez |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

CLI tool for managing shared AI agent configurations

A command-line interface for shaicli.dev - download, share, and sync AI agent configurations (Claude, Cursor, etc.) across projects and teams.

**Dependencies:** thor (~> 1.3), faraday (~> 2.9), tty-prompt (~> 0.23), tty-spinner (~> 0.9), tty-table (~> 0.12), pastel (~> 0.8), diffy (~> 3.4), launchy (~> 2.5)

## [shale](https://shalerb.org)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | Kamil Giszczak |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Ruby object mapper and serializer for XML, JSON, TOML, CSV and YAML.

**Dependencies:** bigdecimal (>= 0)

## [shared_tools](https://github.com/madbomber/shared_tools)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Shared utilities and AI tools for Ruby applications with configurable logging

SharedTools provides a collection of reusable common tools for Ruby applications using ruby_llm gem.

**Dependencies:** ruby_llm (>= 0), ruby_llm-mcp (>= 0), zeitwerk (>= 0), nokogiri (>= 0), dentaku (>= 0), sequel (>= 0), openweathermap (>= 0)

## [shell_tools](https://rubygems.org/gems/shell_tools)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Josh Hull |

Some common shell utils

Some common shell utils.

## [shellany](https://rubygems.org/gems/shellany)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Cezary Baginski |
| **License** | MIT |

Simple, somewhat portable command capturing

MRI+JRuby compatible command output capturing

## [shellwords](https://github.com/ruby/shellwords)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Akinori MUSHA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Manipulates strings with word parsing rules of UNIX Bourne shell.

## [shoulda](https://github.com/thoughtbot/shoulda)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Tammer Saleh, Joe Ferris, Ryan McGeary, Dan Croak, Matt Jankowski |
| **License** | MIT |

Making tests easy on the fingers and eyes

**Dependencies:** shoulda-context (~> 2.0), shoulda-matchers (~> 4.0)

## [shoulda-context](http://thoughtbot.com/community/)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | thoughtbot, inc., Tammer Saleh, Joe Ferris, Ryan McGeary, Dan Croak, Matt Jankowski |
| **License** | MIT |

Context framework extracted from Shoulda

## [shoulda-matchers](https://matchers.shoulda.io/)

| | |
|---|---|
| **Version** | 4.5.1 |
| **Authors** | Tammer Saleh, Joe Ferris, Ryan McGeary, Dan Croak, Matt Jankowski, Stafford Brunk, Elliot Winkler |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Simple one-liner tests for common Rails functionality

Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality that, if written by hand, would be much longer, more complex, and error-prone.

**Dependencies:** activesupport (>= 4.2.0)

## [shrine](https://shrinerb.com)

| | |
|---|---|
| **Version** | 3.6.0 |
| **Authors** | Janko Marohnić |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Toolkit for file attachments in Ruby applications

Shrine is a toolkit for file attachments in Ruby applications. It supports uploading, downloading, processing and deleting IO objects, backed by various storage engines. It uses efficient streaming for low memory usage.  Shrine comes with a high-level interface for attaching uploaded files to database records, saving their location and metadata to a database column, and tying them to record's lifecycle. It natively supports background jobs and direct uploads for fully asynchronous user experience.

**Dependencies:** down (~> 5.1), content_disposition (~> 1.0)

## [sidekiq](https://sidekiq.org)

| | |
|---|---|
| **Version** | 7.3.10 |
| **Authors** | Mike Perham |
| **License** | LGPL-3.0 |
| **Ruby** | >= 2.7.0 |

Simple, efficient background processing for Ruby

Simple, efficient background processing for Ruby.

**Dependencies:** redis-client (>= 0.23.0, < 1), connection_pool (>= 2.3.0, < 3), rack (>= 2.2.4, < 3.3), logger (>= 0), base64 (>= 0)

## [sidekiq-cron](https://github.com/sidekiq-cron/sidekiq-cron)

| | |
|---|---|
| **Version** | 2.3.1 |
| **Authors** | Ondrej Bartas |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Scheduler/Cron for Sidekiq jobs

Enables to set jobs to be run in specified time (using CRON notation or natural language)

**Dependencies:** cronex (>= 0.13.0), fugit (~> 1.8, >= 1.11.1), globalid (>= 1.0.1), sidekiq (>= 6.5.0)

## [sidekiq-limit_fetch](https://github.com/deanpcmad/sidekiq-limit_fetch)

| | |
|---|---|
| **Version** | 4.4.1 |
| **Authors** | Dean Perry |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Sidekiq strategy to support queue limits

Sidekiq strategy to restrict number of workers which are able to run specified queues simultaneously.

**Dependencies:** sidekiq (>= 6)

## [sidekiq-scheduler](https://sidekiq-scheduler.github.io/sidekiq-scheduler/)

| | |
|---|---|
| **Version** | 6.0.1 |
| **Authors** | Morton Jonuschat, Moove-it, Marcelo Lauxen |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Light weight job scheduling extension for Sidekiq

Light weight job scheduling extension for Sidekiq that adds support for queueing jobs in a recurring way.

**Dependencies:** sidekiq (>= 7.3, < 9), rufus-scheduler (~> 3.2)

## [siglip2](https://github.com/khasinski/siglip2-rb)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Krzysztof Hasiński |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Google SigLIP2 embeddings using ONNX models

Ruby implementation of Google's SigLIP2 model for creating text and image embeddings. Uses ONNX models from HuggingFace onnx-community.

**Dependencies:** onnxruntime (~> 0.9), net-http (~> 0.6), numo-narray (~> 0.9), mini_magick (~> 5.0), tokenizers (~> 0.5)

## [signalize](https://codeberg.org/jaredwhite/signalize)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Jared White, Preact Team |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A Ruby port of Signals, providing reactive variables, derived computed state, side effect callbacks, and batched updates.

**Dependencies:** concurrent-ruby (~> 1.2)

## [signet](https://github.com/googleapis/signet)

| | |
|---|---|
| **Version** | 0.21.0 |
| **Authors** | Google LLC |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Signet is an OAuth 1.0 / OAuth 2.0 implementation.

**Dependencies:** addressable (~> 2.8), faraday (>= 0.17.5, < 3.a), jwt (>= 1.5, < 4.0), multi_json (~> 1.10)

## [silencer](http://github.com/spagalloco/silencer)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Steve Agalloco |

Selectively quiet your Rails/Rack logger on a per-route basis

## [simple_acp](https://github.com/madbomber/simple_acp)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.2.0 |

Simple Agent Communication Protocol (ACP) implementation for Ruby

A simple Ruby implementation of the Agent Communication Protocol (ACP) - an open protocol for communication between AI agents, applications, and humans. Supports multimodal messages, real-time streaming, agent discovery, and stateful sessions.

**Dependencies:** roda (~> 3.0), falcon (~> 0.47), async (~> 2.0), async-http (~> 0.66), faraday (~> 2.0), concurrent-ruby (~> 1.2), json_schemer (~> 2.0), base64 (>= 0), uri (>= 0)

## [simple_calendar](https://github.com/excid3/simple_calendar)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Chris Oliver |
| **License** | MIT |

A simple Rails calendar

**Dependencies:** rails (>= 6.1)

## [simple_flow](https://github.com/MadBomber/simple_flow)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A lightweight, modular Ruby framework for building composable data processing pipelines

SimpleFlow provides a clean and flexible architecture for orchestrating multi-step workflows with middleware support, flow control, parallel execution, and immutable results. Perfect for building data processing pipelines with cross-cutting concerns like logging and instrumentation.

## [simple_form](https://github.com/heartcombo/simple_form)

| | |
|---|---|
| **Version** | 5.4.1 |
| **Authors** | José Valim, Carlos Antonio, Rafael França |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Forms made easy!

**Dependencies:** activemodel (>= 7.0), actionpack (>= 7.0)

## [simple_json_schema_builder](https://github.com/mooktakim/simple_json_schema_builder)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Mooktakim Ahmed |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

JSON Schema builder with simple DSL.

Build JSON Schema with simple ruby code, with objects and clean DSL.

**Dependencies:** multi_json (~> 1.0)

## [simple_po_parser](http://github.com/experteer/simple_po_parser)

| | |
|---|---|
| **Version** | 1.1.6 |
| **Authors** | Dennis-Florian Herr |
| **License** | MIT |

A simple PO file to ruby hash parser

A simple PO file to ruby hash parser . PO files are translation files generated by GNU/Gettext tool.

## [simple_rag](https://rubygems.org/gems/simple_rag)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Landon Gray |

Simple Rag is a lightweight library that transforms any Ruby project into a simple RAG application.

## [simplecov](https://github.com/simplecov-ruby/simplecov)

| | |
|---|---|
| **Version** | 0.22.0 |
| **Authors** | Christoph Olszowka, Tobias Pfeiffer |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Code coverage for Ruby

Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites

**Dependencies:** docile (~> 1.1), simplecov-html (~> 0.11), simplecov_json_formatter (~> 0.1)

## [simplecov-cobertura](https://github.com/jessebs/simplecov-cobertura)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Jesse Bowes |
| **License** | Apache-2.0 |
| **Ruby** | >= 2.5.0 |

SimpleCov Cobertura Formatter

Produces Cobertura XML formatted output from SimpleCov

**Dependencies:** simplecov (~> 0.19), rexml (>= 0)

## [simplecov-console](http://github.com/chetan/simplecov-console)

| | |
|---|---|
| **Version** | 0.9.5 |
| **Authors** | Chetan Sarva |
| **License** | MIT |

Simple console output formatter

Simple console output formatter for SimpleCov

**Dependencies:** simplecov (>= 0), terminal-table (>= 0), ansi (>= 0)

## [simplecov-html](https://github.com/simplecov-ruby/simplecov-html)

| | |
|---|---|
| **Version** | 0.13.2 |
| **Authors** | Christoph Olszowka |
| **License** | MIT |
| **Ruby** | >= 2.4 |

Default HTML formatter for SimpleCov code coverage tool for ruby 2.4+

## [simplecov-mcp](https://github.com/keithrbennett/simplecov-mcp)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Keith R. Bennett |
| **License** | MIT |
| **Ruby** | >= 3.2 |

MCP server + CLI for SimpleCov coverage data

Provides an MCP (Model Context Protocol) server and a CLI to inspect SimpleCov coverage, including per-file summaries and uncovered lines.

**Dependencies:** awesome_print (~> 1.9), mcp (~> 0.3), simplecov (>= 0.21, < 1.0)

## [simplecov_json_formatter](https://github.com/fede-moya/simplecov_json_formatter)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Federico Moya |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

JSON formatter for SimpleCov

## [simplecov_lcov_formatter](https://github.com/t-mario-y/simplecov_lcov_formatter)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | t-mario-y |
| **License** | MIT |

LCOV formatter for SimpleCov. Successor of simplecov-lcov.

**Dependencies:** simplecov (>= 0.18)

## [simpleidn](https://github.com/mmriis/simpleidn)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Morten Møller Riis |
| **License** | MIT |
| **Ruby** | >= 2.2 |

Punycode ACE to unicode UTF-8 (and vice-versa) string conversion.

This gem allows easy conversion from punycode ACE strings to unicode UTF-8 strings and vice-versa.

## [sin_lru_redux](https://github.com/cadenza-tech/sin_lru_redux/tree/v2.5.2)

| | |
|---|---|
| **Version** | 2.5.2 |
| **Authors** | Masahiro |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Efficient and thread-safe LRU cache

## [sinatra](http://sinatrarb.com/)

| | |
|---|---|
| **Version** | 4.2.1 |
| **Authors** | Blake Mizerany, Ryan Tomayko, Simon Rozet, Konstantin Haase |
| **License** | MIT |
| **Ruby** | >= 2.7.8 |

Classy web-development dressed in a DSL

Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort.

**Dependencies:** logger (>= 1.6.0), mustermann (~> 3.0), rack (>= 3.0.0, < 4), rack-protection (= 4.2.1), rack-session (>= 2.0.0, < 3), tilt (~> 2.0)

## [sinatra-activerecord](http://github.com/sinatra-activerecord/sinatra-activerecord)

| | |
|---|---|
| **Version** | 2.0.28 |
| **Authors** | Blake Mizerany, Janko Marohnić, Axel Kee |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Extends Sinatra with ActiveRecord helpers.

**Dependencies:** sinatra (>= 1.0), activerecord (>= 4.1)

## [sinatra-contrib](http://sinatrarb.com/contrib/)

| | |
|---|---|
| **Version** | 4.2.1 |
| **Authors** | https://github.com/sinatra/sinatra/graphs/contributors |
| **License** | MIT |
| **Ruby** | >= 2.7.8 |

Collection of useful Sinatra extensions.

Collection of useful Sinatra extensions

**Dependencies:** multi_json (>= 0.0.2), mustermann (~> 3.0), rack-protection (= 4.2.1), sinatra (= 4.2.1), tilt (~> 2.0)

## [single_cov](https://github.com/grosser/single_cov)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Michael Grosser |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Actionable code coverage.

## [singleton](https://github.com/ruby/singleton)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |

The Singleton module implements the Singleton pattern.

## [sirop](http://github.com/digital-fabric/sirop)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Sharon Rosner |
| **License** | MIT |
| **Ruby** | >= 3.4 |

Sirop: Ruby code rewriter

**Dependencies:** prism (~> 1.6)

## [site_prism](https://github.com/site-prism/site_prism)

| | |
|---|---|
| **Version** | 5.1.1 |
| **Authors** | Luke Hill |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.7 |

A Page Object Model DSL for Capybara

SitePrism gives you a simple, clean and semantic DSL for describing your site. SitePrism implements the Page Object Model pattern on top of Capybara.

**Dependencies:** addressable (~> 2.8, >= 2.8.4), capybara (~> 3.34), site_prism-all_there (> 3, < 5)

## [site_prism-all_there](https://github.com/site-prism/site_prism-all_there)

| | |
|---|---|
| **Version** | 3.0.7 |
| **Authors** | Luke Hill |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.7 |

An extension to SitePrism that enables you to recurse through SitePrism Pages and Sections

SitePrism AllThere allows you to recursively query page and section structures on your page - exclusively for use with the SitePrism gem.

## [sixarm_ruby_unaccent](http://sixarm.com/)

| | |
|---|---|
| **Version** | 1.2.2 |
| **Authors** | SixArm |
| **License** | Apache-2.0, Artistic-2.0, BSD-3-Clause, CC-BY-NC-SA-4.0, AGPL-3.0, EPL-1.0, GPL-2.0, GPL-3.0, LGPL-3.0, MIT, MPL-2.0, Ruby |
| **Ruby** | >= 2.2 |

SixArm.com → Ruby → Unaccent

Unaccent replaces a string's accented characters with unaccented characters

## [sketches](http://sketches.rubyforge.org/)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Postmodern |

Sketches allows you to create and edit Ruby code from the comfort of your editor, while having it safely reloaded in IRB whenever changes to the code are saved.

Sketches allows you to create and edit Ruby code from the comfort of your editor, while having it safely reloaded in IRB whenever changes to the code are saved.

## [skooma](https://github.com/skryukov/skooma)

| | |
|---|---|
| **Version** | 0.3.7 |
| **Authors** | Svyatoslav Kryukov |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Validate API implementations against OpenAPI documents.

Apply a documentation-first approach to API development.

**Dependencies:** zeitwerk (~> 2.6), json_skooma (~> 0.2.5)

## [slack-notifier](http://github.com/stevenosloan/slack-notifier)

| | |
|---|---|
| **Version** | 2.4.0 |
| **Authors** | Steven Sloan |
| **License** | MIT |

A slim ruby wrapper for posting to slack webhooks

## [slack-ruby-client](http://github.com/slack-ruby/slack-ruby-client)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | Daniel Doubrovkine |
| **License** | MIT |
| **Ruby** | >= 2.7 |

Slack Web and RealTime API client.

**Dependencies:** faraday (>= 2.0.1), faraday-mashify (>= 0), faraday-multipart (>= 0), gli (>= 0), hashie (>= 0), logger (>= 0)

## [slop](http://github.com/leejarvis/slop)

| | |
|---|---|
| **Version** | 4.10.1 |
| **Authors** | Lee Jarvis |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Simple Lightweight Option Parsing

A DSL for gathering options and parsing command line flags

## [smart_colored](http://github.com/toy/smart_colored)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Ivan Kuchin |
| **License** | MIT |

Color and formatting in terminal

## [smart_init](http://github.com/pawurb/smart_init)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | pawurb |
| **License** | MIT |

Remove Ruby initializer boilerplate code

A smart DSL for ruby initializers boilerplate

## [smart_properties](https://rubygems.org/gems/smart_properties)

| | |
|---|---|
| **Version** | 1.17.0 |
| **Authors** | Konstantin Tennhard |

SmartProperties – Ruby accessors on steroids

SmartProperties are a more flexible and feature-rich alternative to traditional Ruby accessors. They provide support for input conversion, input validation, specifying default values and presence checking.

## [smarter_csv](https://github.com/tilo/smarter_csv)

| | |
|---|---|
| **Version** | 1.15.0 |
| **Authors** | Tilo Sloboda |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Convenient CSV Reading and Writing

Ruby Gem for convenient reading and writing of CSV files. It has intelligent defaults, and auto-discovery of column and row separators. It imports CSV Files as Array(s) of Hashes, suitable for direct processing with ActiveRecord, kicking-off batch jobs with Sidekiq, parallel processing, or oploading data to S3. Similarly, writing CSV files takes Hashes, or Arrays of Hashes to create a CSV file.

## [snaky_hash](https://github.com/oauth-xx/snaky_hash)

| | |
|---|---|
| **Version** | 2.0.3 |
| **Authors** | Peter Boling |
| **License** | MIT |
| **Ruby** | >= 2.2.0 |

A very snaky hash

A Hashie::Mash joint to make #snakelife better

**Dependencies:** hashie (>= 0.1.0, < 6), version_gem (>= 1.1.8, < 3)

## [sniffer](http://github.com/aderyabin/sniffer)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Andrey Deryabin |
| **License** | MIT |

Analyze HTTP Requests

**Dependencies:** anyway_config (>= 1.0), dry-initializer (~> 3)

## [sod](https://alchemists.io/projects/sod)

| | |
|---|---|
| **Version** | 1.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A domain specific language for creating composable command line interfaces.

**Dependencies:** cogger (~> 1.0), containable (~> 1.1), infusible (~> 4.0), optparse (~> 0.8), refinements (~> 13.6), tone (~> 2.0), zeitwerk (~> 2.7)

## [solargraph](https://solargraph.org)

| | |
|---|---|
| **Version** | 0.58.2 |
| **Authors** | Fred Snyder |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A Ruby language server

IDE tools for code completion, inline documentation, and static analysis

**Dependencies:** ast (~> 2.4.3), backport (~> 1.2), benchmark (~> 0.4), bundler (>= 2.0), diff-lcs (~> 1.4), jaro_winkler (~> 1.6, >= 1.6.1), kramdown (~> 2.3), kramdown-parser-gfm (~> 1.1), logger (~> 1.6), observer (~> 0.1), ostruct (~> 0.6), open3 (~> 0.2.1), parser (~> 3.0), prism (~> 1.4), rbs (>= 3.6.1, <= 4.0.0.dev.4), reverse_markdown (~> 3.0), rubocop (~> 1.76), thor (~> 1.0), tilt (~> 2.0), yard (~> 0.9, >= 0.9.24), yard-solargraph (~> 0.1), yard-activesupport-concern (~> 0.0)

## [solid_agent](https://docs.activeagents.ai/solid_agent)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | Justin Bowen |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Database-backed context, tools, and streaming for ActiveAgent

SolidAgent extends ActiveAgent with database-backed prompt context management, declarative tool schemas, and real-time streaming updates. Provides has_context, has_tools, and streams_tool_updates concerns for building robust AI agents.

**Dependencies:** activeagent (>= 1.0.0), activesupport (>= 7.0), activerecord (>= 7.0)

## [solid_cable](https://github.com/rails/solid_cable)

| | |
|---|---|
| **Version** | 3.0.12 |
| **Authors** | Nick Pezza |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Database-backed Action Cable backend.

**Dependencies:** activerecord (>= 7.2), activejob (>= 7.2), actioncable (>= 7.2), railties (>= 7.2)

## [solid_cache](http://github.com/rails/solid_cache)

| | |
|---|---|
| **Version** | 1.0.10 |
| **Authors** | Donal McBreen |
| **License** | MIT |

A database backed ActiveSupport::Cache::Store

**Dependencies:** activerecord (>= 7.2), activejob (>= 7.2), railties (>= 7.2)

## [solid_queue](https://github.com/rails/solid_queue)

| | |
|---|---|
| **Version** | 1.3.1 |
| **Authors** | Rosa Gutierrez |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Database-backed Active Job backend.

**Dependencies:** activerecord (>= 7.1), activejob (>= 7.1), railties (>= 7.1), concurrent-ruby (>= 1.3.1), fugit (~> 1.11), thor (>= 1.3.1)

## [sorbet-baml](https://github.com/vicentereig/sorbet-baml)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Vicente Reig Rincon de Arellano |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Convert Sorbet types to BAML type definitions for LLM prompting

A Ruby gem that converts T::Struct and T::Enum to BAML (Boundary AI Markup Language) type definitions. BAML uses 60% fewer tokens than JSON Schema while maintaining type safety.

**Dependencies:** sorbet-runtime (~> 0.5)

## [sorbet-result](https://github.com/maxveldink/sorbet-result)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Max VelDink |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Adds T::Result to sorbet-runtime, which is a basic, strongly-typed monad

**Dependencies:** sorbet-runtime (~> 0.5)

## [sorbet-runtime](https://sorbet.org)

| | |
|---|---|
| **Version** | 0.6.12925 |
| **Authors** | Stripe |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.0.0 |

Sorbet runtime

Sorbet's runtime type checking component

## [sorbet-schema](https://github.com/maxveldink/sorbet-schema)

| | |
|---|---|
| **Version** | 0.9.3 |
| **Authors** | Max VelDink |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Serialization and deserialization library into Sorbet structs.

**Dependencies:** sorbet-result (~> 1.1), sorbet-runtime (~> 0.5), sorbet-struct-comparable (~> 1.3), zeitwerk (~> 2.6)

## [sorbet-struct-comparable](https://github.com/bellroy/sorbet-struct-comparable)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Bellroy Tech Team |
| **Ruby** | >= 2.0.0 |

Comparable T::Struct's for the equality focused typed Ruby developer.

**Dependencies:** sorbet-runtime (>= 0.5)

## [sorbet-toon](https://github.com/vicentereig/dspy.rb/blob/main/lib/sorbet/toon/README.md)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Vicente Reig Rincón de Arellano |
| **License** | MIT |
| **Ruby** | >= 3.1 |

TOON encode/decode pipeline for Sorbet signatures.

Ruby port of the TOON encoder/decoder used inside DSPy.rb. Provides Sorbet-aware normalization, reconstruction, and prompt-ready helpers so signatures can round-trip through TOON without hand-written serializers.

**Dependencies:** sorbet-runtime (~> 0.5)

## [sorcery](https://github.com/Sorcery/sorcery)

| | |
|---|---|
| **Version** | 0.18.0 |
| **Authors** | Noam Ben Ari, Kir Shatrov, Grzegorz Witek, Chase Gilliam, Josh Buker |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Magical authentication for Rails applications

Provides common authentication needs such as signing in/out, activating by email and resetting password.

**Dependencies:** bcrypt (~> 3.1), oauth (>= 0.6), oauth2 (~> 2.0), railties (>= 7.1)

## [sorted_set](https://github.com/knu/sorted_set)

| | |
|---|---|
| **Version** | 1.0.3 |
| **Authors** | Akinori MUSHA |
| **License** | BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Implements a variant of Set whose elements are sorted in ascending order

**Dependencies:** set (~> 1.0), rbtree (>= 0)

## [spek](https://alchemists.io/projects/spek)

| | |
|---|---|
| **Version** | 4.6.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

An enhanced gem specification wrapper.

**Dependencies:** core (~> 2.5), dry-monads (~> 1.9), refinements (~> 13.6), versionaire (~> 14.0), zeitwerk (~> 2.7)

## [spoon](https://rubygems.org/gems/spoon)

| | |
|---|---|
| **Version** | 0.0.6 |
| **Authors** | Charles Oliver Nutter |
| **License** | Apache-2.0 |

Spoon is an FFI binding of the posix_spawn function (and Windows equivalent), providing fork+exec functionality in a single shot.

**Dependencies:** ffi (>= 0)

## [spreadsheet](https://github.com/zdavatz/spreadsheet)

| | |
|---|---|
| **Version** | 1.3.4 |
| **Authors** | Hannes F. Wyss, Masaomi Hatakeyama, Zeno R.R. Davatz |
| **License** | GPL-3.0 |
| **Ruby** | >= 2.6 |

The Spreadsheet Library is designed to read and write Spreadsheet Documents

As of version 0.6.0, only Microsoft Excel compatible spreadsheets are supported

**Dependencies:** logger (>= 0), bigdecimal (>= 0), ruby-ole (>= 0)

## [spreadsheet_architect](https://github.com/westonganger/spreadsheet_architect)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | Weston Ganger |
| **License** | MIT |

Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets easily from ActiveRecord relations, Plain Ruby classes, or predefined data.

**Dependencies:** caxlsx (<= 4.0), rodf (>= 0), csv (>= 0)

## [spring](https://github.com/rails/spring)

| | |
|---|---|
| **Version** | 4.4.2 |
| **Authors** | Jon Leighton |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Rails application preloader

Preloads your application so things like console, rake and tests run faster

## [sprockets](https://github.com/rails/sprockets)

| | |
|---|---|
| **Version** | 4.2.2 |
| **Authors** | Sam Stephenson, Joshua Peek |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Rack-based asset packaging system

Sprockets is a Rack-based asset packaging system that concatenates and serves JavaScript, CoffeeScript, CSS, Sass, and SCSS.

**Dependencies:** rack (>= 2.2.4, < 4), concurrent-ruby (~> 1.0), logger (>= 0)

## [sprockets-helpers](https://github.com/petebrowne/sprockets-helpers)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Pete Browne |
| **License** | MIT |

Asset path helpers for Sprockets 2.x & 3.x applications

**Dependencies:** sprockets (>= 2.2)

## [sprockets-rails](https://github.com/rails/sprockets-rails)

| | |
|---|---|
| **Version** | 3.5.2 |
| **Authors** | Joshua Peek |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Sprockets Rails integration

**Dependencies:** sprockets (>= 3.0.0), actionpack (>= 6.1), activesupport (>= 6.1)

## [sqa-tai](https://github.com/MadBomber/sqa-tai)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

SQA::TAI - Technical Analysis Indicators

An SQA-specific wrapper around the ta_lib_ffi gem which access to TA-Lib providing many technical analysis indicators for stock analysis. Part of the SQA (Simple Qualitative Analysis) ecosystem.

**Dependencies:** ta_lib_ffi (~> 0.3)

## [sqlite-vec](https://github.com/TODO)

| | |
|---|---|
| **Version** | 0.1.6 |
| **Authors** | Alex Garcia |
| **License** | MIT OR Apache |

A vector search SQLite extension.

## [sqlite3](https://github.com/sparklemotion/sqlite3-ruby)

| | |
|---|---|
| **Version** | 1.7.3 |
| **Authors** | Jamis Buck, Luis Lavena, Aaron Patterson, Mike Dalessio |
| **License** | BSD-3-Clause |
| **Ruby** | >= 2.7 |

Ruby library to interface with the SQLite3 database engine (http://www.sqlite.org).

Ruby library to interface with the SQLite3 database engine (http://www.sqlite.org). Precompiled binaries are available for common platforms for recent versions of Ruby.

**Dependencies:** mini_portile2 (~> 2.8.0)

## [squasher](https://github.com/jalkoby/squasher)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | Sergey Pchelintsev |
| **License** | MIT |

Squash your old migrations

## [sshkit](http://github.com/capistrano/sshkit)

| | |
|---|---|
| **Version** | 1.25.0 |
| **Authors** | Lee Hambley, Tom Clements |
| **License** | MIT |
| **Ruby** | >= 2.5 |

SSHKit makes it easy to write structured, testable SSH commands in Ruby

A comprehensive toolkit for remotely running commands in a structured manner on groups of servers.

**Dependencies:** base64 (>= 0), logger (>= 0), net-ssh (>= 2.8.0), net-scp (>= 1.1.2), net-sftp (>= 2.1.2), ostruct (>= 0)

## [stackprof](http://github.com/tmm1/stackprof)

| | |
|---|---|
| **Version** | 0.2.27 |
| **Authors** | Aman Gupta |
| **License** | MIT |
| **Ruby** | >= 2.2 |

sampling callstack-profiler for ruby 2.2+

stackprof is a fast sampling profiler for ruby code, with cpu, wallclock and object allocation samplers.

## [standard](https://github.com/standardrb/standard)

| | |
|---|---|
| **Version** | 1.53.0 |
| **Authors** | Justin Searls |
| **Ruby** | >= 3.0.0 |

Ruby Style Guide, with linter & automatic code fixer

**Dependencies:** rubocop (~> 1.82.0), lint_roller (~> 1.0), standard-custom (~> 1.0.0), standard-performance (~> 1.8), language_server-protocol (~> 3.17.0.2)

## [standard-custom](https://github.com/standardrb/standard-custom)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Justin Searls |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Plugin containing implementations of custom cops that are bundled as defaults in Standard Ruby

**Dependencies:** lint_roller (~> 1.0), rubocop (~> 1.50)

## [standard-performance](https://github.com/standardrb/standard-performance)

| | |
|---|---|
| **Version** | 1.9.0 |
| **Authors** | Justin Searls |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Standard Ruby Plugin providing configuration for rubocop-performance

**Dependencies:** lint_roller (~> 1.1), rubocop-performance (~> 1.26.0)

## [state_machines](https://github.com/state-machines/state_machines)

| | |
|---|---|
| **Version** | 0.100.4 |
| **Authors** | Abdelkader Boudih, Aaron Pfeifer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

State machines for attributes

Adds support for creating state machines for attributes on any Ruby class

## [state_machines-activemodel](https://github.com/state-machines/state_machines-activemodel)

| | |
|---|---|
| **Version** | 0.101.0 |
| **Authors** | Abdelkader Boudih, Aaron Pfeifer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

ActiveModel integration for State Machines

Adds support for creating state machines for attributes on ActiveModel

**Dependencies:** state_machines (>= 0.100.4), activemodel (>= 7.2)

## [state_machines-activerecord](https://github.com/state-machines/state_machines-activerecord/)

| | |
|---|---|
| **Version** | 0.100.0 |
| **Authors** | Abdelkader Boudih, Aaron Pfeifer |
| **License** | MIT |
| **Ruby** | >= 3.2 |

State machines Active Record Integration

Adds support for creating state machines for attributes on ActiveRecord

**Dependencies:** activerecord (>= 7.2), state_machines-activemodel (>= 0.100.0)

## [statesman](https://github.com/gocardless/statesman)

| | |
|---|---|
| **Version** | 13.1.0 |
| **Authors** | GoCardless |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A statesman-like state machine library

## [steep](https://github.com/soutaro/steep)

| | |
|---|---|
| **Version** | 1.10.0 |
| **Authors** | Soutaro Matsumoto |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Gradual Typing for Ruby

**Dependencies:** parser (>= 3.1), activesupport (>= 5.1), rainbow (>= 2.2.2, < 4.0), listen (~> 3.0), language_server-protocol (>= 3.17.0.4, < 4.0), rbs (~> 3.9), concurrent-ruby (>= 1.1.10), terminal-table (>= 2, < 5), securerandom (>= 0.1), json (>= 2.1.0), logger (>= 1.3.0), fileutils (>= 1.1.0), strscan (>= 1.0.0), csv (>= 3.0.9), uri (>= 0.12.0), mutex_m (>= 0.3.0)

## [stemmer](http://rubyforge.org/projects/stemmer/)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Matt Mower |
| **Ruby** | > 0.0.0 |

Word stemming algorithm(s)

## [stepped](https://github.com/envirobly/stepped)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Robert Starsi |
| **License** | MIT |

Rails engine for orchestrating complex action trees.

**Dependencies:** rails (>= 8.1.1)

## [stimulus-rails](https://stimulus.hotwired.dev)

| | |
|---|---|
| **Version** | 1.3.4 |
| **Authors** | Sam Stephenson, Javan Mahkmali, David Heinemeier Hansson |
| **License** | MIT |

A modest JavaScript framework for the HTML you already have.

**Dependencies:** railties (>= 6.0.0)

## [stoplight](https://github.com/bolshakov/stoplight)

| | |
|---|---|
| **Version** | 5.7.0 |
| **Authors** | Cameron Desautels, Taylor Fausak, Justin Steffy |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Traffic control for code.

An implementation of the circuit breaker pattern.

**Dependencies:** zeitwerk (>= 0), concurrent-ruby (>= 0)

## [stopwords-filters](http://github.com/brenes/stopwords-filters)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Silviu Panaite |
| **License** | MIT |

Snowball based filters for stopwords

Small library that allows you to create a simple stopwords filter or use some based on Snowball stopwords lists

## [store_attribute](http://github.com/palkan/store_attribute)

| | |
|---|---|
| **Version** | 2.1.1 |
| **Authors** | palkan |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

ActiveRecord extension which adds typecasting to store accessors

**Dependencies:** activerecord (>= 7.2)

## [store_model](https://github.com/DmitryTsepelev/store_model)

| | |
|---|---|
| **Version** | 4.5.0 |
| **Authors** | DmitryTsepelev |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Gem for working with JSON-backed attributes as ActiveRecord models

**Dependencies:** activerecord (>= 7.0)

## [streamio-ffmpeg](http://github.com/streamio/streamio-ffmpeg)

| | |
|---|---|
| **Version** | 3.0.2 |
| **Authors** | Rackfish AB |

Wraps ffmpeg to read metadata and transcodes videos.

**Dependencies:** multi_json (~> 1.8)

## [streamlined](https://codeberg.org/jaredwhite/streamlined)

| | |
|---|---|
| **Version** | 0.6.2 |
| **Authors** | Bridgetown Team |
| **License** | MIT |
| **Ruby** | >= 3.1 |

HTML fragment & component rendering for Ruby using streamlined procs & heredocs.

**Dependencies:** serbea (>= 2.1), zeitwerk (~> 2.5)

## [strict_ivars](https://github.com/yippee-fun/strict_ivars)

| | |
|---|---|
| **Version** | 1.0.2 |
| **Authors** | Joel Drapper |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Make Ruby raise a NameError if you read an undefined instance variable.

Strict Ivars is a tiny pre-processor that guards you against undefined instance variable reads. If you do read an undefined instance variable, it will raise a NameError.

**Dependencies:** require-hooks (~> 0.2), prism (>= 0)

## [string-format](https://github.com/socketry/string-format)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Samuel Williams |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Formatting utilities for strings.

## [string-similarity](https://github.com/mhutter/string-similarity)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Manuel Hutter |
| **License** | MIT |

Various methods for calculating string similarities.

== Description  This gem provides some methods for calculating similarities of two strings.  === Currently implemented  - Cosine similarity - Levenshtein distance/similarity  === Planned  - Hamming similarity

## [stringio](https://github.com/ruby/stringio)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Nobu Nakada, Charles Oliver Nutter |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7 |

Pseudo IO on String

Pseudo `IO` class from/to `String`.

## [strings](https://github.com/piotrmurach/strings)

| | |
|---|---|
| **Version** | 0.2.1 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A set of methods for working with strings.

A set of methods for working with strings such as align, truncate, wrap and many more.

**Dependencies:** strings-ansi (~> 0.2), unicode_utils (~> 1.4), unicode-display_width (>= 1.5, < 3.0)

## [strings-ansi](https://github.com/piotrmurach/strings-ansi)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Methods for processing ANSI escape codes in strings.

## [strip_attributes](https://github.com/rmm5t/strip_attributes)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Ryan McGeary |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Whitespace cleanup for ActiveModel attributes

StripAttributes automatically strips all ActiveRecord model attributes of leading and trailing whitespace before validation. If the attribute is blank, it strips the value to nil.

**Dependencies:** activemodel (>= 3.0, < 9.0)

## [strong_migrations](https://github.com/ankane/strong_migrations)

| | |
|---|---|
| **Version** | 2.5.2 |
| **Authors** | Andrew Kane, Bob Remeika, David Waller |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Catch unsafe migrations in development

**Dependencies:** activerecord (>= 7.1)

## [strscan](https://github.com/ruby/strscan)

| | |
|---|---|
| **Version** | 3.1.6 |
| **Authors** | Minero Aoki, Sutou Kouhei, Charles Oliver Nutter |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.4.0 |

Provides lexical scanning operations on a String.

## [stuff-classifier](https://github.com/alexandru/stuff-classifier/)

| | |
|---|---|
| **Version** | 0.5 |
| **Authors** | Alexandru Nedelcu |

Simple text classifier(s) implemetation

2 methods are provided for now - (1) naive bayes implementation + (2) tf-idf weights

**Dependencies:** fast-stemmer (>= 1.0), sqlite3 (>= 0), sequel (>= 0), msgpack (>= 0)

## [sublayer](https://docs.sublayer.com)

| | |
|---|---|
| **Version** | 0.2.9 |
| **Authors** | Scott Werner |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

A model-agnostic Ruby GenerativeAI DSL and Framework

A DSL and framework for building AI powered applications through the use of Generators, Actions, Tasks, and Agents

**Dependencies:** ruby-openai (>= 0), activesupport (>= 0), zeitwerk (>= 0), httparty (>= 0), listen (>= 0), ostruct (>= 0), thor (>= 0)

## [sugar_refinery](https://janlelis.github.io/sugar_refinery)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.0 |

The Ruby Sugar Refinery is a collection of tiny refinements.

The Ruby Sugar Refinery is a collection of tiny refinements (declarative local core extensions).

## [summary](http://github.com/azisaka/summary)

| | |
|---|---|
| **Version** | 0.7.3 |
| **Authors** | Bruno, Azisaka, Maciel |

This is a simple gem that generates introduction text from a long text, it will always break the text at the end of the last word near to the limit you informed as argument.

## [super_diff](https://github.com/splitwise/super_diff)

| | |
|---|---|
| **Version** | 0.18.0 |
| **Authors** | Elliot Winkler, Splitwise, Inc. |
| **License** | MIT |
| **Ruby** | >= 3.1 |

A better way to view differences between complex data structures in RSpec.

SuperDiff is a gem that hooks into RSpec to intelligently display the differences between two data structures of any type.

**Dependencies:** attr_extras (>= 6.2.4), diff-lcs (>= 0), patience_diff (>= 0)

## [superform](https://github.com/rubymonolith/superform)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Brad Gessler |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Build forms in Rails

A better way to customize and build forms for your Rails application

**Dependencies:** phlex-rails (~> 2.0), zeitwerk (~> 2.6)

## [superglue](https://github.com/thoughtbot/superglue_rails/)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Johny Ho |
| **License** | MIT |

Rails integration for SuperglueJS

**Dependencies:** actionpack (>= 7.0, < 9.0), props_template (~> 0.37), form_props (~> 0.2)

## [supermail](https://github.com/beautifulruby/supermail)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Brad Gessler |
| **Ruby** | >= 3.1.0 |

Build emails with plain ol' Ruby objects.

**Dependencies:** actionmailer (>= 7.0)

## [svn_wc](http://github.com/dvwright/svn_wc)

| | |
|---|---|
| **Version** | 0.0.6 |
| **Authors** | David Wright |

svn_wc operates on a working copy (on the local filesystem) of a remote Subversion repository.

svn_wc provides programmatic access to basic svn functions, utilizing the Subversion Ruby Bindings, exposing their functionality in a simplified way

## [swagger-ui](http://github.com/justindell/swagger)

| | |
|---|---|
| **Version** | 0.0.2 |
| **Authors** | Justin Dell, Brian Tatnall |
| **License** | MIT |

Swagger UI

Swagger UI wrapper

**Dependencies:** actionpack (>= 0)

## [swarm_cli](https://github.com/parruda/swarm)

| | |
|---|---|
| **Version** | 2.1.13 |
| **Authors** | Paulo Arruda |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Command-line interface for SwarmSDK

SwarmCLI provides a command-line interface for SwarmSDK, the lightweight multi-agent AI orchestration framework. Built with the TTY toolkit, it offers an intuitive and interactive way to define, manage, and execute AI agent swarms with progress indicators, formatted output, and comprehensive help documentation.

**Dependencies:** fast-mcp (~> 1.6), pastel (>= 0), reline (~> 0.6.3), swarm_sdk (~> 2.7), tty-box (>= 0), tty-cursor (>= 0), tty-link (>= 0), tty-markdown (>= 0), tty-option (>= 0), tty-spinner (>= 0), tty-tree (>= 0), zeitwerk (>= 0), csv (>= 0), docx (~> 0.10), pdf-reader (~> 2.15), reverse_markdown (~> 3.0.0), roo (~> 3.0.0)

## [swarm_sdk](https://github.com/parruda/swarm)

| | |
|---|---|
| **Version** | 2.7.14 |
| **Authors** | Paulo Arruda |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Lightweight multi-agent AI orchestration using RubyLLM

SwarmSDK is a complete reimagining of Claude Swarm that runs all AI agents in a single process using RubyLLM for LLM interactions. Define collaborative AI agents in simple Markdown files with YAML frontmatter, and orchestrate them without the overhead of multiple processes or MCP inter-process communication. Perfect for building lightweight, efficient AI agent teams with specialized roles and capabilities.

**Dependencies:** async (~> 2.0), async-http-faraday (~> 0.22), faraday-follow_redirects (~> 0.4), ruby_llm (~> 1.11), ruby_llm_swarm-mcp (~> 0.8.2), zeitwerk (~> 2.6)

## [swd](https://github.com/nov/swd)

| | |
|---|---|
| **Version** | 2.0.3 |
| **Authors** | nov matake |

SWD (Simple Web Discovery) Client Library

**Dependencies:** faraday (~> 2.0), faraday-follow_redirects (>= 0), activesupport (>= 3), attr_required (>= 0.0.5)

## [sweet-moon](https://github.com/gbaptista/sweet-moon)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | gbaptista |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Lua / Fennel from Ruby and vice versa. Support to LuaJIT, Lua 5.0, and 5.1. Lua C API for Lua 5, 4, and 3. LuaRocks and fnx integration.

A resilient solution that makes working with Lua / Fennel from Ruby and vice versa a delightful experience.  Support to LuaJIT, Lua 5.0, and 5.1. Lua C API for Lua 5, 4, and 3. LuaRocks and fnx integration.

**Dependencies:** ffi (~> 1.17)

## [symbolize](http://github.com/nofxx/symbolize)

| | |
|---|---|
| **Version** | 4.5.2 |
| **Authors** | Marcos Piccinini |
| **License** | MIT |

Object enums with i18n in AR or Mongoid

ActiveRecord/Mongoid enums with i18n

**Dependencies:** i18n (>= 0), activemodel (>= 3.2, < 5), activesupport (>= 3.2, < 5)

## [sync](https://github.com/ruby/sync)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Keiju ISHITSUKA |
| **License** | BSD-2-Clause |

A module that provides a two-phase lock with a counter.

## [syntax_finder](https://github.com/ko1/syntax_finder)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Koichi Sasada |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Analyze your Ruby scripts with prism.

## [syntax_suggest](https://github.com/ruby/syntax_suggest.git)

| | |
|---|---|
| **Version** | 2.0.2 |
| **Authors** | schneems |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Find syntax errors in your source in a snap

When you get an "unexpected end" in your syntax this gem helps you find it

## [syntax_tree](https://github.com/kddnewton/syntax_tree)

| | |
|---|---|
| **Version** | 6.3.0 |
| **Authors** | Kevin Newton |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

A parser based on ripper

**Dependencies:** prettier_print (>= 1.2.0)

## [syntax_tree_ext](https://github.com/synvert-hq/syntax_tree_ext)

| | |
|---|---|
| **Version** | 0.9.2 |
| **Authors** | Richard Huang |
| **Ruby** | >= 2.6.0 |

extend syntax_tree

extend syntax_tree, add parent and sibling

**Dependencies:** syntax_tree (>= 0)

## [synvert](https://github.com/synvert-hq/synvert-ruby)

| | |
|---|---|
| **Version** | 1.11.0 |
| **Authors** | Richard Huang |
| **License** | MIT |

synvert = syntax + convert.

synvert is used to convert ruby code to better syntax.

**Dependencies:** synvert-core (>= 2.0.2)

## [synvert-core](https://github.com/synvert-hq/synvert-core-ruby)

| | |
|---|---|
| **Version** | 2.3.0 |
| **Authors** | Richard Huang |
| **License** | MIT |

convert ruby code to better syntax.

convert ruby code to better syntax automatically.

**Dependencies:** activesupport (>= 0), node_query (>= 1.17.0), node_mutation (>= 1.25.0), node_visitor (>= 1.1.0), parser (>= 0), parser_node_ext (>= 1.4.2), syntax_tree (>= 0), syntax_tree_ext (>= 0.9.2), prism (>= 0), prism_ext (>= 0.4.2), parallel (>= 0)

## [sys-proctable](http://github.com/djberg96/sys-proctable)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Daniel J. Berger |
| **License** | Apache-2.0 |

An interface for providing process table information

The sys-proctable library provides an interface for gathering information about processes on your system, i.e. the process table. Most major platforms are supported and, while different platforms may return different information, the external interface is identical across platforms.

**Dependencies:** ffi (~> 1.1)

## [sys-uname](http://github.com/djberg96/sys-uname)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | Daniel J. Berger |
| **License** | Apache-2.0 |

An interface for returning uname (platform) information

The sys-uname library provides an interface for gathering information about your current platform. The library is named after the Unix 'uname' command but also works on MS Windows. Available information includes OS name, OS version, system name and so on. Additional information is available for certain platforms.

**Dependencies:** ffi (~> 1.1), memoist3 (~> 1.0.0)

## [syslog](https://github.com/ruby/syslog)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Akinori MUSHA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Ruby interface for the POSIX system logging facility.

**Dependencies:** logger (>= 0)

## [systemu](https://github.com/ahoward/systemu)

| | |
|---|---|
| **Version** | 2.6.5 |
| **Authors** | Ara T. Howard |
| **License** | Ruby |

systemu

universal capture of stdout and stderr and handling of child process pid for windows, *nix, etc.

## [t-ruby](https://type-ruby.github.io)

| | |
|---|---|
| **Version** | 0.0.46 |
| **Authors** | Y. Fred Kim |
| **License** | BSD-2-Clause |
| **Ruby** | >= 3.1.0 |

T-Ruby - TypeScript-style types for Ruby

t-ruby compiles .trb files with type annotations to executable Ruby (.rb) and optional type signature files (.rbs)

**Dependencies:** benchmark (>= 0), thor (~> 1.0)

## [ta_lib_ffi](https://github.com/TA-Lib/ta-lib-ruby)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Victor Yang |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Ruby FFI bindings for TA-Lib (Technical Analysis Library)

A Ruby wrapper for TA-Lib using FFI, providing technical analysis functions for financial market data

**Dependencies:** fiddle (~> 1.1)

## [table_tennis](https://github.com/gurgeous/table_tennis)

| | |
|---|---|
| **Version** | 0.0.7 |
| **Authors** | Adam Doppelt |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Stylish tables in your terminal.

**Dependencies:** csv (~> 3.3), ffi (~> 1.17), memo_wise (~> 1.11), paint (~> 2.3), unicode-display_width (~> 3.1)

## [tabreader](https://github.com/csv11/tabreader)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

tabreader - read in tabular datafiles in text in the tabular (TAB) format

## [tabulo](https://github.com/matt-harvey/tabulo)

| | |
|---|---|
| **Version** | 3.0.3 |
| **Authors** | Matthew Harvey |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Terminal table generator

Plain text table generator with a column-based API

**Dependencies:** tty-screen (= 0.8.2), unicode-display_width (~> 3.0)

## [tailwindcss-rails](https://github.com/rails/tailwindcss-rails)

| | |
|---|---|
| **Version** | 4.4.0 |
| **Authors** | David Heinemeier Hansson |
| **License** | MIT |

Integrate Tailwind CSS with the asset pipeline in Rails.

**Dependencies:** railties (>= 7.0.0), tailwindcss-ruby (~> 4.0)

## [tailwindcss-ruby](https://github.com/flavorjones/tailwindcss-ruby)

| | |
|---|---|
| **Version** | 4.1.18 |
| **Authors** | Mike Dalessio, David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

A self-contained `tailwindcss` executable.

A self-contained `tailwindcss` executable, wrapped up in a ruby gem. That's it. Nothing else.

## [taskjuggler](http://www.taskjuggler.org)

| | |
|---|---|
| **Version** | 3.8.4 |
| **Authors** | Chris Schlaeger |
| **License** | GPL-2.0-only |
| **Ruby** | >= 2.0.0 |

A Project Management Software

TaskJuggler is a modern and powerful, Free and Open Source Software project management tool. It's new approach to project planning and tracking is more flexible and superior to the commonly used Gantt chart editing tools.  TaskJuggler is project management software for serious project managers. It covers the complete spectrum of project management tasks from the first idea to the completion of the project. It assists you during project scoping, resource assignment, cost and revenue planning, risk and communication management.

**Dependencies:** mail (~> 2.7, >= 2.7.1), webrick (~> 1.9, >= 1.9.1), term-ansicolor (~> 1.7, >= 1.7.1)

## [telegram-bot-ruby](https://github.com/atipugin/telegram-bot)

| | |
|---|---|
| **Version** | 2.5.0 |
| **Authors** | Alexander Tipugin |
| **Ruby** | >= 2.7 |

Ruby wrapper for Telegram's Bot API

**Dependencies:** dry-struct (~> 1.6), faraday (~> 2.0), faraday-multipart (~> 1.0), zeitwerk (~> 2.6)

## [tempfile](https://github.com/ruby/tempfile)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

A utility class for managing temporary files.

## [temple](https://github.com/judofyr/temple)

| | |
|---|---|
| **Version** | 0.10.4 |
| **Authors** | Magnus Holm, Daniel Mendler |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

Template compilation framework in Ruby

## [temporal](https://github.com/clivecrous/temporal)

| | |
|---|---|
| **Version** | 0.4.4 |
| **Authors** | Clive Crous |
| **License** | MIT |

A natural language date and time parser

This project is still in early development. Only the mathematical side is complete. eg: Time.now + 3.years + 2.months

## [temporary_tables](https://github.com/keygen-sh/temporary_tables)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Zeke Gabrielse |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Create temporary tables for Rspec tests.

**Dependencies:** activerecord (>= 6.0)

## [term-ansicolor](https://github.com/flori/term-ansicolor)

| | |
|---|---|
| **Version** | 1.11.3 |
| **Authors** | Florian Frank |
| **License** | Apache-2.0 |

Ruby library that colors strings using ANSI escape sequences

This library uses ANSI escape sequences to control the attributes of terminal output

**Dependencies:** tins (~> 1)

## [terminal-size](https://github.com/rking/terminal-size)

| | |
|---|---|
| **Version** | 0.0.6 |
| **Authors** | ☈king, Norrin |

A tiny gem to accomplish a simple task: Determining the terminal size.

A tiny gem to accomplish a simple task: Determining the terminal size.  == Usage  p Terminal.size # ⇒ {height: 90, width: 161} p Terminal.size! # to get 80×25 as a fallback instead of nil

## [terminal-table](https://github.com/tj/terminal-table)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | TJ Holowaychuk, Scott J. Goldman |
| **License** | MIT |

Simple, feature rich ascii table generation library

**Dependencies:** unicode-display_width (~> 1.1, >= 1.1.1)

## [terminalwire](https://terminalwire.com/ruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Brad Gessler |
| **License** | Proprietary (https://terminalwire.com/license) |
| **Ruby** | >= 3.0.0 |

Ship a CLI for your web app. No API required.

Stream command-line apps from your server without a web API

**Dependencies:** terminalwire-client (= 0.3.4)

## [terminalwire-client](https://terminalwire.com/ruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Brad Gessler |
| **License** | Proprietary (https://terminalwire.com/license) |
| **Ruby** | >= 3.0.0 |

Ship a CLI for your web app. No API required.

Stream command-line apps from your server without a web API

**Dependencies:** launchy (~> 3.0), terminalwire-core (= 0.3.4)

## [terminalwire-core](https://terminalwire.com/ruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Brad Gessler |
| **License** | Proprietary (https://terminalwire.com/license) |
| **Ruby** | >= 3.0.0 |

Ship a CLI for your web app. No API required.

Stream command-line apps from your server without a web API

**Dependencies:** async-websocket (~> 0.30), zeitwerk (~> 2.0), msgpack (~> 1.7), uri-builder (~> 0.1.9), base64 (~> 0.2.0)

## [terminalwire-rails](https://terminalwire.com/ruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Brad Gessler |
| **License** | Proprietary (https://terminalwire.com/license) |
| **Ruby** | >= 3.0.0 |

Ship a CLI for your web app. No API required.

Stream command-line apps from your server without a web API

**Dependencies:** terminalwire-server (= 0.3.4), jwt (~> 2.0)

## [terminalwire-server](https://terminalwire.com/ruby)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Brad Gessler |
| **License** | Proprietary (https://terminalwire.com/license) |
| **Ruby** | >= 3.0.0 |

Ship a CLI for your web app. No API required.

Stream command-line apps from your server without a web API

**Dependencies:** thor (~> 1.3), terminalwire-core (= 0.3.4)

## [terrapin](https://github.com/thoughtbot/terrapin)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Jon Yurek |
| **License** | MIT |

Run shell commands safely, even with user-supplied values

**Dependencies:** climate_control (>= 0)

## [test-cmd.rb](https://github.com/0x1eef/test-cmd.rb#readme)

| | |
|---|---|
| **Version** | 0.12.4 |
| **Authors** | 0x1eef |
| **License** | 0BSD |
| **Ruby** | >= 3.0 |

An object-oriented interface for spawning a command

## [test-kitchen](https://kitchen.ci/)

| | |
|---|---|
| **Version** | 4.0.0 |
| **Authors** | Fletcher Nichol |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1 |

Test Kitchen is an integration tool for developing and testing infrastructure code and software on isolated target platforms.

**Dependencies:** bcrypt_pbkdf (~> 1.0), chef-utils (>= 16.4.35), csv (~> 3.3), ed25519 (~> 1.3), irb (~> 1.15), mixlib-install (~> 3.6), mixlib-shellout (>= 1.2, < 4.0), net-scp (>= 1.1, < 5.0), net-ssh (>= 2.9, < 8.0), net-ssh-gateway (>= 1.2, < 3.0), ostruct (~> 0.6), syslog (~> 0.3), thor (>= 0.19, < 2.0), chef-winrm (>= 2.5.0, < 3.0), chef-winrm-elevated (>= 1.0, < 2.0), chef-winrm-fs (>= 1.0, < 2.0)

## [test-prof](http://github.com/test-prof/test-prof)

| | |
|---|---|
| **Version** | 1.5.2 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Ruby applications tests profiling tools

Ruby applications tests profiling tools.  Contains tools to analyze factories usage, integrate with Ruby profilers, profile your examples using ActiveSupport notifications (if any) and statically analyze your code with custom RuboCop cops.

## [test-unit](https://test-unit.github.io/)

| | |
|---|---|
| **Version** | 3.7.7 |
| **Authors** | Kouhei Sutou, Haruka Yoshihara |
| **License** | Ruby, BSDL, PSFL |

An xUnit family unit testing framework for Ruby.

test-unit (Test::Unit) is unit testing framework for Ruby, based on xUnit principles. These were originally designed by Kent Beck, creator of extreme programming software development methodology, for Smalltalk's SUnit. It allows writing tests, checking results and automated testing in Ruby.

**Dependencies:** power_assert (>= 0)

## [therubyrhino](http://github.com/cowboyd/therubyrhino)

| | |
|---|---|
| **Version** | 2.1.2 |
| **Authors** | Charles Lowell |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Embed the Rhino JavaScript interpreter into JRuby

Call javascript code and manipulate javascript objects from ruby. Call ruby code and manipulate ruby objects from javascript.

**Dependencies:** therubyrhino_jar (>= 1.7.4, < 1.7.9)

## [therubyrhino_jar](http://github.com/cowboyd/therubyrhino)

| | |
|---|---|
| **Version** | 1.7.8 |
| **Authors** | Charles Lowell, Karol Bucek |
| **License** | MPL-2.0 |

Rhino's jars packed for therubyrhino

Rhino's js.jar classes packaged as a JRuby gem.

## [thor](http://github.com/wycats/thor)

| | |
|---|---|
| **Version** | 0.14.6 |
| **Authors** | Yehuda Katz, JosÃ© Valim |

A scripting framework that replaces rake, sake and rubigen

## [thread](http://github.com/meh/ruby-thread)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | meh. |
| **License** | WTFPL |

Various extensions to the base thread library.

Includes a thread pool, message passing capabilities, a recursive mutex, promise, future and delay.

## [thread_safe](https://github.com/ruby-concurrency/thread_safe)

| | |
|---|---|
| **Version** | 0.3.6 |
| **Authors** | Charles Oliver Nutter, thedarkone |
| **License** | Apache-2.0 |

Thread-safe collections and utilities for Ruby

A collection of data structures and utilities to make thread-safe programming in Ruby easier

## [throttle_machines](https://github.com/seuros/throttle_machines)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Advanced Rate limiting for Ruby applications

ThrottleMachines provides ultra-thin, elegant rate limiting with temporal precision for distributed systems.

**Dependencies:** activesupport (>= 8.0.4), concurrent-ruby (~> 1.3), rack (~> 3.0), zeitwerk (~> 2.7), breaker_machines (~> 0.7), chrono_machines (>= 0.2)

## [thruster](https://github.com/basecamp/thruster)

| | |
|---|---|
| **Version** | 0.1.18 |
| **Authors** | Kevin McConnell |
| **License** | MIT |

Zero-config HTTP/2 proxy

A zero-config HTTP/2 proxy for lightweight production deployments

## [tiktoken_ruby](https://github.com/IAPark/tiktoken_ruby)

| | |
|---|---|
| **Version** | 0.0.15.1 |
| **Authors** | IAPark |
| **License** | MIT |
| **Ruby** | >= 3.2, < 4.1.dev |

Ruby wrapper for Tiktoken

An unofficial Ruby wrapper for Tiktoken, a BPE tokenizer written by and used by OpenAI. It can be used to count the number of tokens in text before sending it to OpenAI APIs.

## [tilt](https://github.com/jeremyevans/tilt)

| | |
|---|---|
| **Version** | 2.7.0 |
| **Authors** | Ryan Tomayko, Magnus Holm, Jeremy Evans |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Generic interface to multiple Ruby template engines

## [time](https://github.com/ruby/time)

| | |
|---|---|
| **Version** | 0.4.2 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.4.0 |

Extends the Time class with methods for parsing and conversion.

**Dependencies:** date (>= 0)

## [timecop](https://github.com/travisjeffery/timecop)

| | |
|---|---|
| **Version** | 0.9.10 |
| **Authors** | Travis Jeffery, John Trupiano |
| **License** | MIT |
| **Ruby** | >= 1.9.2 |

A gem providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code.  It provides a unified method to mock Time.now, Date.today, and DateTime.now in a single call.

## [timeliness](http://github.com/adzap/timeliness)

| | |
|---|---|
| **Version** | 0.5.3 |
| **Authors** | Adam Meehan |
| **License** | MIT |

Date/time parsing for the control freak.

Fast date/time parser with customisable formats, timezone and I18n support.

## [timeout](https://github.com/ruby/timeout)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.6.0 |

Auto-terminate potentially long-running operations in Ruby.

## [timers](https://github.com/socketry/timers)

| | |
|---|---|
| **Version** | 4.4.0 |
| **Authors** | Tony Arcieri, Samuel Williams, Donovan Keme, Wander Hillen, Utenmiki, Jeremy Hinegardner, Sean Gregory, Chuck Remes, Olle Jonsson, Ron Evans, Tommy Ong Gia Phu, Larry Lv, Lin Jen-Shin, Ryunosuke Sato, Atul Bhosale, Bruno Enten, Dimitrij Denissenko, Jesse Cooke, Klaus Trainer, Lavir the Whiolet, Mike Bourgeous, Nicholas Evans, Patrik Wenger, Peter Goldstein, Ryan LeCompte, Tim Smith, Vít Ondruch, Will Jessop, Yoshiki Takagi |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Pure Ruby one-shot and periodic timers.

## [tins](https://github.com/flori/tins)

| | |
|---|---|
| **Version** | 1.51.1 |
| **Authors** | Florian Frank |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Useful stuff.

All the stuff that isn't good/big enough for a real library.

**Dependencies:** sync (>= 0), bigdecimal (>= 0), readline (>= 0), mize (~> 0.6)

## [tiny-classifier](https://github.com/piroor/tiny-classifier)

| | |
|---|---|
| **Version** | 2.2 |
| **Authors** | YUKI "Piro" Hiroshi |
| **License** | GPLv3 or later |

On-memory text classifier command line tool, based on naive bayes.

**Dependencies:** classifier-reborn (>= 0), natto (>= 0)

## [tiny_mcp](https://github.com/maxim/tiny_mcp)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Max Chernyak |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

Tiny Ruby-based MCP server

Make local MCP tools in Ruby and easily serve them.

## [tldr](https://github.com/tendersearls/tldr)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Justin Searls, Aaron Patterson |
| **License** | MIT |
| **Ruby** | >= 3.1 |

TLDR will run your tests, but only for 1.8 seconds.

**Dependencies:** super_diff (~> 0.10), concurrent-ruby (~> 1.2), irb (~> 1.10)

## [tmpdir](https://github.com/ruby/tmpdir)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

Extends the Dir class to manage the OS temporary file path.

**Dependencies:** fileutils (>= 0)

## [to_bool](http://github.com/bricker/to_bool)

| | |
|---|---|
| **Version** | 2.1.0 |
| **Authors** | Bryan Ricker |
| **License** | MIT |

Convert any object naturally into a boolean

Super-simple gem that extends some Ruby classes with a "to_bool" method, which converts any object naturally into a boolean.

## [to_llm](https://github.com/jcmaciel/to_llm)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | José Carlos Maciel |
| **License** | MIT |

Extracts code from a Rails project to text files for LLM usage.

A simple gem that provides a Rails command or Rake tasks to export .rb, .erb, .js, and .yml files into .txt or .md for LLM ingestion.

**Dependencies:** rails (>= 5.0)

## [tocer](https://alchemists.io/projects/tocer)

| | |
|---|---|
| **Version** | 19.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A command line interface for generating Markdown table of contents.

**Dependencies:** cogger (~> 1.0), containable (~> 1.1), core (~> 2.5), dry-schema (~> 1.13), etcher (~> 3.0), infusible (~> 4.0), refinements (~> 13.6), runcom (~> 12.0), sod (~> 1.5), spek (~> 4.0), zeitwerk (~> 2.7)

## [tokenizers](https://github.com/ankane/tokenizers-ruby)

| | |
|---|---|
| **Version** | 0.6.3 |
| **Authors** | Andrew Kane |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.2, < 4.1.dev |

Fast state-of-the-art tokenizers for Ruby

## [toml](http://github.com/jm/toml)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Jeremy McAnally, Dirk Gadsden |
| **License** | MIT |

Parse your TOML.

Parse your TOML, seriously.

**Dependencies:** parslet (>= 1.8.0, < 3.0.0)

## [toml-rb](https://github.com/emancu/toml-rb)

| | |
|---|---|
| **Version** | 4.1.0 |
| **Authors** | Emiliano Mancuso, Lucas Tolchinsky |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Toml parser in ruby, for ruby.

A Toml parser using Citrus parsing library.

**Dependencies:** citrus (~> 3.0, > 3.0), racc (~> 1.7)

## [tomlrb](https://github.com/fbernier/tomlrb)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Francois Bernier |
| **License** | MIT |
| **Ruby** | >= 2.0 |

A racc based toml parser

## [tone](https://alchemists.io/projects/tone)

| | |
|---|---|
| **Version** | 2.6.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A customizable ANSI text terminal colorizer.

**Dependencies:** refinements (~> 13.6), zeitwerk (~> 2.7)

## [tool_forge](https://github.com/afstanton/tool_forge)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Aaron F Stanton |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Build AI tools for LLMs with a single DSL

A Ruby gem for building AI tools for large language models using a simple domain-specific language.

**Dependencies:** zeitwerk (>= 0)

## [toon-ruby](https://github.com/andrepcg/toon-ruby)

| | |
|---|---|
| **Version** | 0.1.1 |
| **Authors** | André Perdigão |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Token-Oriented Object Notation – a token-efficient JSON alternative for LLM prompts

TOON is a compact, human-readable format designed for passing structured data to Large Language Models with significantly reduced token usage.

## [top_secret](https://github.com/thoughtbot/top_secret)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Steve Polito |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Filter sensitive information from free text.

Filter sensitive information from free text before sending it to external services or APIs, such as chatbots and LLMs.

**Dependencies:** activesupport (>= 7.0.8, < 9), mitie (~> 0.3.2)

## [tou](https://github.com/cheddar-me/tou)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Sebastian van Hesteren, Julik Tarkhanov |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Time-ordered UUIDv4

## [touring_test](https://github.com/stwerner92/touring_test)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Scott Werner |
| **Ruby** | >= 3.2.0 |

A Cucumber support gem for using Google's 'computer use' Gemini model.

This gem provides a simple way to use Google's 'computer use' Gemini model within your Cucumber step definitions, allowing you to write high-level instructions for an AI agent to execute.

**Dependencies:** cucumber (>= 0), capybara (>= 0), httparty (>= 0), playwright-ruby-client (>= 0)

## [tracer](https://github.com/ruby/tracer)

| | |
|---|---|
| **Version** | 0.2.3 |
| **Authors** | Stan Lo, Keiju ISHITSUKA |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.7.0 |

A Ruby tracer

## [traces](https://github.com/socketry/traces)

| | |
|---|---|
| **Version** | 0.18.2 |
| **Authors** | Samuel Williams, Felix Yan, Zach Taylor |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Application instrumentation and tracing.

## [track_open_instances](https://github.com/main-branch/track_open_instances)

| | |
|---|---|
| **Version** | 0.1.15 |
| **Authors** | James Couball |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A mixin to ensure that all instances of a class are closed

A mixin to track instances of Ruby classes that require explicit cleanup, helping to identify potential resource leaks. It maintains a list of created instances and allows checking for any that remain unclosed.

## [trailblazer-option](https://trailblazer.to/)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Nick Sutterer |
| **License** | MIT |
| **Ruby** | >= 2.1.0 |

Callable patterns for options in Trailblazer

Wrap an option at compile-time and `call` it at runtime, which allows to have the common `-> ()`, `:method` or `Callable` pattern used for most options.

## [train-core](https://rubygems.org/gems/train-core)

| | |
|---|---|
| **Version** | 3.16.1 |
| **Authors** | Chef InSpec Team |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.1.0 |

Transport interface to talk to a selected set of backends.

A minimal Train with a backends for ssh and winrm.

**Dependencies:** addressable (~> 2.5), ffi (>= 1.16.0, < 1.18), json (>= 1.8, < 3.0), mixlib-shellout (>= 2.0, < 4.0), net-scp (>= 1.2, < 5.0), net-ssh (>= 2.9, < 8.0)

## [trak_flow](https://github.com/madbomber/trak_flow)

| | |
|---|---|
| **Version** | 0.1.3 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

A distributed task tracking system for Robots

TrakFlow is a specialized task tracking system designed for robots. It implements a dependency-aware graph, allowing robots to handle complex/lengthy task workflows without losing context. Tasks are stored as JSONL files within a designated directory, using Git as the underlying database for versioning, branching, and merging.

**Dependencies:** anyway_config (~> 2.0), debug_me (>= 0), fast-mcp (>= 0), oj (~> 3.16), pastel (~> 0.8), sequel (~> 5.0), sqlite3 (~> 2.0), thor (~> 1.3), tty-spinner (~> 0.9), tty-table (~> 0.12), puma (~> 6.0), rackup (~> 2.0)

## [transitions](http://github.com/troessner/transitions)

| | |
|---|---|
| **Version** | 1.3.0 |
| **Authors** | Timo Rößner |
| **License** | MIT |

State machine extracted from ActiveModel

Lightweight state machine extracted from ActiveModel

## [transproc](http://solnic.github.io/transproc/)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Transform Ruby objects in functional style

## [tree_haver](https://github.com/kettle-rb/tree_haver)

| | |
|---|---|
| **Version** | 5.0.4 |
| **Authors** | Peter H. Boling |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

🌴 Cross-Ruby adapter for AST parsing libraries, like tree-sitter, citrus, & parslet; works on MRI, JRuby, and TruffleRuby

🌴 TreeHaver is a cross-Ruby adapter for many AST parsing libraries; supporting MRI Ruby, JRuby, & TruffleRuby. Provides unified parsing API & AST when using ruby_tree_sitter, parslet, citrus, ffi, tree_stump (Rust), JRuby JARs, etc. As Faraday is to HTTP clients, this is for ASTs: 'Learn once & write once & run anywhere'

**Dependencies:** version_gem (~> 1.1, >= 1.1.9)

## [treetop](https://github.com/cjheath/treetop)

| | |
|---|---|
| **Version** | 1.6.18 |
| **Authors** | Nathan Sobo, Clifford Heath |
| **License** | MIT |

A Ruby-based text parsing and interpretation DSL

A Parsing Expression Grammar (PEG) Parser generator DSL for Ruby

**Dependencies:** polyglot (~> 0.3)

## [trick_bag](https://github.com/keithrbennett/trick_bag)

| | |
|---|---|
| **Version** | 0.70.0 |
| **Authors** | Keith Bennett |
| **License** | MIT |

Miscellaneous general useful tools.

Miscellaneous general useful tools for general purpose programming.

**Dependencies:** os (~> 1.1), diffy (~> 3.0), net-ssh (>= 0)

## [trollop](http://manageiq.github.io/optimist/)

| | |
|---|---|
| **Version** | 2.9.10 |
| **Authors** | William Morgan, Keenan Brock |
| **License** | MIT |

Trollop is a commandline option parser for Ruby that just gets out of your way.

Trollop is a commandline option parser for Ruby that just gets out of your way.  **DEPRECATION** This gem has been renamed to optimist and will no longer be supported. Please switch to optimist as soon as possible.

## [tsort](https://github.com/ruby/tsort)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Tanaka Akira |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Topological sorting using Tarjan's algorithm

## [ttfunk](http://prawnpdf.org/)

| | |
|---|---|
| **Version** | 1.8.0 |
| **Authors** | Alexander Mankuta, Gregory Brown, Brad Ediger, Daniel Nelson, Jonathan Greenberg, James Healy, Cameron Dutro |
| **License** | Nonstandard, GPL-2.0-only, GPL-3.0-only |
| **Ruby** | >= 2.7 |

TrueType Font Metrics Parser

Font Metrics Parser for the Prawn PDF generator

**Dependencies:** bigdecimal (~> 3.1)

## [tty-box](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Draw various frames and boxes in the terminal window.

**Dependencies:** pastel (~> 0.8), tty-cursor (~> 0.7), strings (~> 0.2.0)

## [tty-color](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Terminal color capabilities detection

## [tty-color-cli](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A command-line tool for terminal color capabilities detection

**Dependencies:** tty-color (~> 0.5)

## [tty-command](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.10.1 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Execute shell commands with pretty output logging and capture their stdout, stderr and exit status.

Execute shell commands with pretty output logging and capture their stdout, stderr and exit status. Redirect stdin, stdout and stderr of each command to a file or a string.

**Dependencies:** pastel (~> 0.8)

## [tty-config](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A highly customisable application configuration interface for building terminal tools.

A highly customisable application configuration interface for building terminal tools. It supports many file formats such as YAML, JSON, TOML, INI, HCL and Java Properties.

## [tty-cursor](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.7.1 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Terminal cursor positioning, visibility and text manipulation.

The purpose of this library is to help move the terminal cursor around and manipulate text by using intuitive method calls.

## [tty-editor](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Open a file or text in a preferred terminal text editor.

**Dependencies:** tty-prompt (~> 0.22)

## [tty-file](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.10.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

File manipulation utility methods.

**Dependencies:** pastel (~> 0.8), tty-prompt (~> 0.22), diff-lcs (~> 1.3)

## [tty-fireworks](https://github.com/dapplebeforedawn/ruby-fireworks)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Mark Lorenz |

For those extra special commits

Fireworks in your terminal

## [tty-font](https://piotrmurach.github.io/tty)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Terminal fonts

Write text in large stylized characters using a variety of terminal friendly fonts.

## [tty-link](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Terminal hyperlinks support detection and generation.

## [tty-logger](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.6.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Readable, structured and beautiful terminal logging

**Dependencies:** pastel (~> 0.8)

## [tty-markdown](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.7.2 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Convert a markdown text or document into a terminal friendly output.

**Dependencies:** kramdown (>= 1.16.2, < 3.0), pastel (~> 0.8), rouge (>= 3.14, < 5.0), strings (~> 0.2.0), tty-color (~> 0.5), tty-screen (~> 0.8)

## [tty-option](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

An intuitive and flexible command line parser.

Parser for command line arguments, keywords, flags, options and environment variables.

## [tty-pager](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.14.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A cross-platform terminal pager that works on all major Ruby interpreters.

**Dependencies:** tty-screen (~> 0.8), strings (~> 0.2.0)

## [tty-pie](https://piotrmurach.github.io/tty)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Draw pie charts in your terminal window.

**Dependencies:** pastel (~> 0.8), tty-cursor (~> 0.7)

## [tty-platform](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Query methods for detecting different operating systems and their properties.

## [tty-process-ctl](http://github.com/jpastuszek/tty-process-ctl)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Jakub Pastuszek |
| **License** | MIT |

Control of interactive terminal applications via simple API.

This gem was created to enable control of interactive terminal applications. It is using pseudo tty to communicate with the process via simple API.

## [tty-progressbar](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.18.3 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A flexible and extensible progress bar for terminal applications.

Display a single or multiple progress bars in the terminal. A progress bar can show determinate or indeterminate progress that can be paused and resumed at any time. A bar format supports many tokens for common information display like elapsed time, estimated time to completion, mean rate and more.

**Dependencies:** strings-ansi (~> 0.2), tty-cursor (~> 0.7), tty-screen (~> 0.8), unicode-display_width (>= 1.6, < 3.0)

## [tty-prompt](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.23.1 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A beautiful and powerful interactive command line prompt.

A beautiful and powerful interactive command line prompt with a robust API for getting and validating complex inputs.

**Dependencies:** pastel (~> 0.8), tty-reader (~> 0.8)

## [tty-prompt-vim](https://github.com/jbodah/tty-prompt-vim)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Josh Bodah |

Dead-simple Vim-like bindings extension for tty-prompt

Vim-like bindings extension for tty-prompt

**Dependencies:** tty-prompt (~> 0.16)

## [tty-reader](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A set of methods for processing keyboard input in character, line and multiline modes.

A set of methods for processing keyboard input in character, line and multiline modes. It maintains history of entered input with an ability to recall and re-edit those inputs. It lets you register to listen for keystroke events and trigger custom key events yourself.

**Dependencies:** tty-screen (~> 0.8), tty-cursor (~> 0.7), wisper (~> 2.0)

## [tty-screen](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.8.2 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Terminal screen size detection.

Terminal screen size detection that works on Linux, macOS and Windows systems and supports Ruby MRI, JRuby, TruffleRuby and Rubinius interpreters.

## [tty-spinner](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.9.3 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A terminal spinner for tasks that have non-deterministic time frame.

**Dependencies:** tty-cursor (~> 0.7)

## [tty-table](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

A flexible and intuitive table generator

**Dependencies:** pastel (~> 0.8), strings (~> 0.2.0), tty-screen (~> 0.8)

## [tty-tree](https://piotrmurach.github.io/tty)

| | |
|---|---|
| **Version** | 0.4.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Print directory or structured data in a tree like format.

## [tty-which](https://ttytoolkit.org)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Platform independent implementation of Unix which command.

## [turbo-rails](https://github.com/hotwired/turbo-rails)

| | |
|---|---|
| **Version** | 2.0.23 |
| **Authors** | Sam Stephenson, Javan Mahkmali, David Heinemeier Hansson |
| **License** | MIT |
| **Ruby** | >= 3.1 |

The speed of a single-page web application without having to write any JavaScript.

**Dependencies:** actionpack (>= 7.1.0), railties (>= 7.1.0)

## [turbo_power](https://github.com/marcoroth/turbo_power-rails)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Marco Roth |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Power-pack for Turbo Streams

**Dependencies:** turbo-rails (>= 1.3.0)

## [twilio-ruby](https://github.com/twilio/twilio-ruby)

| | |
|---|---|
| **Version** | 7.10.1 |
| **Authors** | Twilio API Team |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

The official library for communicating with the Twilio REST API, building TwiML, and generating Twilio JWT Capability Tokens

**Dependencies:** jwt (>= 1.5, < 4.0), nokogiri (>= 1.6, < 2.0), faraday (>= 0.9, < 3.0)

## [twitter-text](http://twitter.com)

| | |
|---|---|
| **Version** | 1.14.7 |
| **Authors** | Matt Sanford, Patrick Ewing, Ben Cherry, Britt Selvitelle, Raffi Krikorian, J.P. Cummins, Yoshimasa Niwa, Keita Fujii, James Koval |
| **License** | Apache 2.0 |

Twitter text handling library

A gem that provides text handling for Twitter

**Dependencies:** unf (~> 0.1.0)

## [typed_bus](https://github.com/MadBomber/typed_bus)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Dewayne VanHoozer |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Async pub/sub message bus with typed channels, ACK-based delivery, and dead letter queues

A lightweight async message bus built on the async gem with fiber-only concurrency. Provides typed pub/sub channels with explicit acknowledgment, dead letter queues, bounded backpressure, delivery timeout tracking, and per-channel statistics.

**Dependencies:** async (~> 2.0)

## [typeprof](https://github.com/ruby/typeprof)

| | |
|---|---|
| **Version** | 0.31.1 |
| **Authors** | Yusuke Endoh |
| **License** | MIT |
| **Ruby** | >= 3.3 |

TypeProf is a type analysis tool for Ruby code based on abstract interpretation

TypeProf performs a type analysis of non-annotated Ruby code.  It abstractly executes input Ruby code in a level of types instead of values, gathers what types are passed to and returned by methods, and prints the analysis result in RBS format, a standard type description format for Ruby 3.0.

**Dependencies:** prism (>= 1.4.0), rbs (>= 3.6.0)

## [typhoeus](https://github.com/typhoeus/typhoeus)

| | |
|---|---|
| **Version** | 1.4.1 |
| **Authors** | David Balatero, Paul Dix, Hans Hasselberg |
| **License** | MIT |

Parallel HTTP library on top of libcurl multi.

Like a modern code version of the mythical beast with 100 serpent heads, Typhoeus runs HTTP requests in parallel while cleanly encapsulating handling logic.

**Dependencies:** ethon (>= 0.9.0)

## [tzinfo](http://tzinfo.github.io)

| | |
|---|---|
| **Version** | 0.3.62 |
| **Authors** | Philip Ross |
| **License** | MIT |

Daylight-savings aware timezone library

TZInfo is a Ruby library that uses the standard tz (Olson) database to provide daylight savings aware transformations between times in different time zones.

## [tzinfo-data](https://tzinfo.github.io)

| | |
|---|---|
| **Version** | 1.2025.3 |
| **Authors** | Philip Ross |
| **License** | MIT |
| **Ruby** | >= 1.8.7 |

Timezone Data for TZInfo

TZInfo::Data contains data from the IANA Time Zone database packaged as Ruby modules for use with TZInfo.

**Dependencies:** tzinfo (>= 1.0.0)

## [uber](https://github.com/apotonick/uber)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Nick Sutterer |
| **License** | MIT |

Gem-authoring tools like generic builders, dynamic options and more.

A gem-authoring framework.

## [uglifier](https://github.com/lautis/uglifier)

| | |
|---|---|
| **Version** | 4.2.1 |
| **Authors** | Ville Lautanala |
| **License** | MIT |
| **Ruby** | >= 2.4.0 |

Ruby wrapper for UglifyJS JavaScript compressor

Uglifier minifies JavaScript files by wrapping UglifyJS to be accessible in Ruby

**Dependencies:** execjs (>= 0.3.0, < 3)

## [un](https://github.com/ruby/un)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | WATANABE Hirofumi |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3.0 |

Utilities to replace common UNIX commands

## [undercover](https://github.com/grodowski/undercover)

| | |
|---|---|
| **Version** | 0.8.4 |
| **Authors** | Jan Grodowski |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Actionable code coverage - detects untested code blocks in recent changes

**Dependencies:** base64 (>= 0), bigdecimal (>= 0), imagen (>= 0.2.0), rainbow (>= 2.1, < 4.0), rugged (>= 0.27, < 1.10), simplecov (>= 0), simplecov_json_formatter (>= 0)

## [unf](https://github.com/knu/ruby-unf)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Akinori MUSHA |
| **License** | 2-clause BSDL |

A wrapper library to bring Unicode Normalization Form support to Ruby/JRuby

This is a wrapper library to bring Unicode Normalization Form support to Ruby/JRuby.

**Dependencies:** unf_ext (>= 0)

## [unf_ext](https://github.com/knu/ruby-unf_ext)

| | |
|---|---|
| **Version** | 0.0.9.1 |
| **Authors** | Takeru Ohta, Akinori MUSHA |
| **License** | MIT |
| **Ruby** | >= 2.2 |

Unicode Normalization Form support library for CRuby

## [unicode](http://www.yoshidam.net/Ruby.html#unicode)

| | |
|---|---|
| **Version** | 0.4.4.5 |
| **Authors** | Yoshida Masato |
| **License** | Ruby |

Unicode normalization library.

## [unicode-display_width](http://github.com/janlelis/unicode-display_width)

| | |
|---|---|
| **Version** | 1.1.3 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Determines the monospace display width of a string in Ruby.

[Unicode 9.0.0] Determines the monospace display width of a string using EastAsianWidth.txt, Unicode general category, and other data.

## [unicode-emoji](https://github.com/janlelis/unicode-emoji)

| | |
|---|---|
| **Version** | 4.2.0 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Emoji data and regex

[Emoji 17.0] Provides Unicode Emoji data and regexes, incorporating the latest Unicode and Emoji standards. Includes a categorized list of recommended Emoji.

## [unicode-version](https://github.com/janlelis/unicode-version)

| | |
|---|---|
| **Version** | 1.6.0 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Ruby / Unicode / Emoji versions mapping

Returns Unicode / Emoji versions of current and previous Rubies

## [unicode_plot](https://github.com/red-data-tools/unicode_plot.rb)

| | |
|---|---|
| **Version** | 0.0.5 |
| **Authors** | mrkn |
| **License** | MIT |

Plot your data by Unicode characters

**Dependencies:** enumerable-statistics (>= 2.0.1)

## [unicode_utils](http://github.com/lang/unicode_utils)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Stefan Lang |
| **Ruby** | >= 1.9.1 |

additional Unicode aware functions for Ruby 1.9

## [universalid](https://github.com/hopsoft/universalid)

| | |
|---|---|
| **Version** | 0.1.7 |
| **Authors** | Nate Hopkins (hopsoft) |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Fast, recursive, optimized, URL-Safe serialization for any Ruby object

Universal ID opens the flood gates with a deluge of profoundly powerful yet easily implemented new use-cases for your apps and scripts.

**Dependencies:** activesupport (>= 6.1), brotli (>= 0.4), config (>= 5.0), msgpack (>= 1.7), zeitwerk (>= 2.6)

## [unparser](http://github.com/mbj/unparser)

| | |
|---|---|
| **Version** | 0.6.15 |
| **Authors** | Markus Schirp |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Generate equivalent source for parser gem AST nodes

**Dependencies:** diff-lcs (~> 1.3), parser (>= 3.3.0)

## [unpoly-rails](https://github.com/unpoly/unpoly-rails)

| | |
|---|---|
| **Version** | 3.12.0 |
| **Authors** | Henning Koch |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

Rails bindings for Unpoly, the unobtrusive JavaScript framework

**Dependencies:** railties (>= 3.2), actionpack (>= 3.2), activesupport (>= 3.2), memoized (>= 0)

## [unread](https://github.com/ledermann/unread)

| | |
|---|---|
| **Version** | 0.14.0 |
| **Authors** | Georg Ledermann |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Manages read/unread status of ActiveRecord objects

This gem creates a scope for unread objects and adds methods to mark objects as read

**Dependencies:** activerecord (>= 6.1)

## [uri](https://github.com/ruby/uri)

| | |
|---|---|
| **Version** | 1.1.1 |
| **Authors** | Akira Yamada |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5 |

URI is a module providing classes to handle Uniform Resource Identifiers

## [uri-builder](https://github.com/rubymonolith/uri-builder)

| | |
|---|---|
| **Version** | 0.1.13 |
| **Authors** | Brad Gessler |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Build URIs via chains

## [uri-idna](https://github.com/skryukov/uri-idna)

| | |
|---|---|
| **Version** | 0.3.1 |
| **Authors** | Svyatoslav Kryukov |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Internationalized Domain Names for Ruby (IDNA2008, UTS46 and WHATWG)

Internationalized Domain Names in Applications (IDNA)

## [useragent](https://github.com/gshutler/useragent)

| | |
|---|---|
| **Version** | 0.16.11 |
| **Authors** | Joshua Peek, Garry Shutler |
| **License** | MIT |

HTTP User Agent parser

## [valid_email2](https://github.com/micke/valid_email2)

| | |
|---|---|
| **Version** | 7.0.13 |
| **Authors** | Micke Lisinge |
| **License** | MIT |
| **Ruby** | >= 3.1.0 |

ActiveModel validation for email. Including MX lookup and disposable email deny list

**Dependencies:** mail (~> 2.5), activemodel (>= 6.0)

## [validate_email](http://github.com/perfectline/validates_email/tree/master)

| | |
|---|---|
| **Version** | 0.1.6 |
| **Authors** | Tanel Suurhans, Tarmo Lehtpuu |

Library for validating email addresses in Rails 3 models.

**Dependencies:** mail (>= 2.2.5), activemodel (>= 3.0)

## [validate_url](http://github.com/perfectline/validates_url/tree/master)

| | |
|---|---|
| **Version** | 1.0.15 |
| **Authors** | Tanel Suurhans, Tarmo Lehtpuu, Vladimir Krylov |

Library for validating urls in Rails.

**Dependencies:** activemodel (>= 3.0.0), public_suffix (>= 0)

## [validates_timeliness](https://github.com/adzap/validates_timeliness)

| | |
|---|---|
| **Version** | 8.0.0 |
| **Authors** | Adam Meehan |
| **License** | MIT |

Date and time validation plugin for Rails which allows custom formats

Adds validation methods to ActiveModel for validating dates and times. Works with multiple ORMS.

**Dependencies:** activemodel (>= 8.0.0, < 9), timeliness (>= 0.3.10, < 1)

## [vcr](https://benoittgt.github.io/vcr)

| | |
|---|---|
| **Version** | 6.4.0 |
| **Authors** | Myron Marston, Kurtis Rainbolt-Greene, Olle Jonsson |
| **License** | Hippocratic-2.1, MIT |
| **Ruby** | >= 2.7 |

Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.

## [vega](https://github.com/ankane/vega-ruby)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Andrew Kane |
| **License** | BSD-3-Clause |
| **Ruby** | >= 3.2 |

Interactive charts for Ruby, powered by Vega and Vega-Lite

## [verbal_expressions](http://github.com/ryan-endacott/verbal_expressions)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | Ryan Endacott |
| **License** | MIT |

Library that makes difficult regular expressions easy!

Verbal Expressions is a library that makes constructing difficult regular expressions simple and easy!

## [vernier](https://github.com/jhawthorn/vernier)

| | |
|---|---|
| **Version** | 1.9.0 |
| **Authors** | John Hawthorn |
| **License** | MIT |
| **Ruby** | >= 3.2.1 |

A next generation CRuby profiler

Next-generation Ruby 3.2.1+ sampling profiler. Tracks multiple threads, GVL activity, GC pauses, idle time, and more.

## [verse](https://github.com/piotrmurach/verse)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Piotr Murach |
| **License** | MIT |

Text transformations such as truncation, wrapping, aligning, indentation and grouping of words.

**Dependencies:** unicode_utils (~> 1.4.0), unicode-display_width (~> 1.1.0)

## [version_gem](https://github.com/ruby-oauth/version_gem)

| | |
|---|---|
| **Version** | 1.1.9 |
| **Authors** | Peter Boling |
| **License** | MIT |
| **Ruby** | >= 2.2 |

🔖 Enhance your VERSION! Sugar for Version modules.

🔖 Versions are good. Versions are cool. Versions will win.

## [versionaire](https://alchemists.io/projects/versionaire)

| | |
|---|---|
| **Version** | 14.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

An immutable, thread-safe, and strict semantic version type.

**Dependencies:** refinements (~> 13.6)

## [vessel](https://github.com/route/vessel)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Dmitry Vorotilin |
| **License** | MIT |
| **Ruby** | >= 2.3.0 |

High-level web crawling framework

Vessel is a high-level web crawling framework, used to crawl websites and extract structured data from their pages

**Dependencies:** ferrum (>= 0.8), thor (~> 1.0)

## [vial](https://github.com/seuros/vial)

| | |
|---|---|
| **Version** | 0.2026.1.15.0 |
| **Authors** | Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.4.0 |

Vial: Fixtures, Reinvented

Vial compiles programmable fixture intent into explicit, deterministic fixtures for Rails.

**Dependencies:** activerecord (>= 8.1)

## [view_component](https://viewcomponent.org)

| | |
|---|---|
| **Version** | 4.2.0 |
| **Authors** | ViewComponent Team |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

A framework for building reusable, testable & encapsulated view components in Ruby on Rails.

**Dependencies:** activesupport (>= 7.1.0), actionview (>= 7.1.0), concurrent-ruby (~> 1)

## [view_component-contrib](http://github.com/palkan/view_component-contrib)

| | |
|---|---|
| **Version** | 0.2.5 |
| **Authors** | Vladimir Dementyev |
| **License** | MIT |
| **Ruby** | >= 2.7 |

A collection of extensions and developer tools for ViewComponent

**Dependencies:** view_component (>= 0), ruby-next-core (>= 0.15.0)

## [virtus](https://github.com/solnic/virtus)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Piotr Solnica |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Attributes on Steroids for Plain Old Ruby Objects

**Dependencies:** descendants_tracker (~> 0.0, >= 0.0.3), coercible (~> 1.0), axiom-types (~> 0.1)

## [vite_rails](https://github.com/ElMassimo/vite_ruby)

| | |
|---|---|
| **Version** | 3.0.20 |
| **Authors** | Máximo Mussini |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Use Vite in Rails and bring joy to your JavaScript experience

**Dependencies:** railties (>= 5.1, < 9), vite_ruby (>= 3.2.2, ~> 3.0)

## [vite_ruby](https://github.com/ElMassimo/vite_ruby)

| | |
|---|---|
| **Version** | 3.9.2 |
| **Authors** | Máximo Mussini |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Use Vite in Ruby and bring joy to your JavaScript experience

**Dependencies:** dry-cli (>= 0.7, < 2), logger (~> 1.6), mutex_m (>= 0), rack-proxy (~> 0.6, >= 0.6.1), zeitwerk (~> 2.2)

## [vsm](https://github.com/sublayerapp/vsm)

| | |
|---|---|
| **Version** | 0.2.0 |
| **Authors** | Scott Werner |
| **License** | MIT |
| **Ruby** | >= 3.4 |

Async, recursive agent framework for Ruby (Viable System Model): capsules, tools-as-capsules, streaming tool calls, and observability.

VSM is a small Ruby framework for building agentic systems using a Viable System Model–style architecture. It gives you Capsules: self‑contained components composed of five named systems (Operations, Coordination, Intelligence, Governance, Identity) plus an async runtime so many capsules can run concurrently.

**Dependencies:** async (~> 2.27), async-http (~> 0.90), rack (~> 3.2)

## [warden](https://github.com/hassox/warden)

| | |
|---|---|
| **Version** | 1.2.9 |
| **Authors** | Daniel Neighman, Justin Smestad, Whitney Smestad, José Valim |
| **License** | MIT |

An authentication library compatible with all Rack-based frameworks

**Dependencies:** rack (>= 2.0.9)

## [wasabi](https://github.com/savonrb/wasabi)

| | |
|---|---|
| **Version** | 5.1.0 |
| **Authors** | Daniel Harrington |
| **License** | MIT |
| **Ruby** | >= 3.0 |

A simple WSDL parser

**Dependencies:** faraday (>= 1.9, < 3), nokogiri (>= 1.13.9), addressable (>= 0)

## [wasmtime](https://github.com/BytecodeAlliance/wasmtime-rb)

| | |
|---|---|
| **Version** | 41.0.1 |
| **Authors** | The Wasmtime Project Developers |
| **License** | Apache-2.0 |
| **Ruby** | >= 3.2, < 4.1.dev |

Wasmtime bindings for Ruby

A Ruby binding for Wasmtime, a WebAssembly runtime.

## [waterdrop](https://karafka.io)

| | |
|---|---|
| **Version** | 2.8.15 |
| **Authors** | Maciej Mensfeld |
| **License** | LGPL-3.0-only, Commercial |
| **Ruby** | >= 3.2.0 |

Kafka messaging made easy!

**Dependencies:** karafka-core (>= 2.4.9, < 3.0.0), karafka-rdkafka (>= 0.23.1), zeitwerk (~> 2.3)

## [watir](https://github.com/watir/watir)

| | |
|---|---|
| **Version** | 7.3.0 |
| **Authors** | Alex Rodionov, Titus Fortner, Justin Ko |
| **License** | MIT |
| **Ruby** | >= 3.0.0 |

Watir powered by Selenium

Watir stands for Web Application Testing In Ruby It facilitates the writing of automated tests by mimicing the behavior of a user interacting with a website.

**Dependencies:** regexp_parser (>= 1.2, < 3), selenium-webdriver (~> 4.2)

## [weakref](https://github.com/ruby/weakref)

| | |
|---|---|
| **Version** | 0.1.4 |
| **Authors** | Yukihiro Matsumoto |
| **License** | Ruby, BSD-2-Clause |

Allows a referenced object to be garbage-collected.

**Dependencies:** delegate (>= 0)

## [weaviate-ruby](https://github.com/andreibondarev/weaviate-ruby)

| | |
|---|---|
| **Version** | 0.9.2 |
| **Authors** | Andrei Bondarev |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Ruby wrapper for the Weaviate.io API

**Dependencies:** faraday (>= 2.0.1, < 3.0), graphlient (>= 0.7.0, < 0.9.0)

## [web-console](https://github.com/rails/web-console)

| | |
|---|---|
| **Version** | 4.2.1 |
| **Authors** | Hailey Somerville, Genadi Samokovarov, Guillermo Iguaran, Ryan Dao |
| **License** | MIT |
| **Ruby** | >= 2.5 |

A debugging tool for your Ruby on Rails applications.

**Dependencies:** railties (>= 6.0.0), activemodel (>= 6.0.0), actionview (>= 6.0.0), bindex (>= 0.4.0)

## [web-push](https://github.com/pushpad/web-push)

| | |
|---|---|
| **Version** | 3.1.0 |
| **Authors** | zaru, collimarco |
| **License** | MIT |
| **Ruby** | >= 3.0 |

Web Push library for Ruby (RFC8030)

**Dependencies:** jwt (~> 3.0), openssl (>= 3.0)

## [webclient](https://github.com/rubycoco/webclient)

| | |
|---|---|
| **Version** | 0.2.2 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 2.2.2 |

webclient gem - yet (another) universal network client interface for world wide web (www) requests via HTTP

## [webdrivers](https://github.com/titusfortner/webdrivers)

| | |
|---|---|
| **Version** | 5.3.1 |
| **Authors** | Titus Fortner, Lakshya Kapoor, Thomas Walpole |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Easy download and use of browser drivers.

Run Selenium tests more easily with install and updates for all supported webdrivers.

**Dependencies:** nokogiri (~> 1.6), rubyzip (>= 1.3.0), selenium-webdriver (~> 4.0, < 4.11)

## [webfinger](https://github.com/nov/webfinger)

| | |
|---|---|
| **Version** | 2.1.3 |
| **Authors** | nov matake |
| **License** | MIT |

Ruby WebFinger client library, following IETF WebFinger WG spec updates.

Ruby WebFinger client library

**Dependencies:** faraday (~> 2.0), faraday-follow_redirects (>= 0), activesupport (>= 0)

## [webget](https://github.com/rubycoco/webclient)

| | |
|---|---|
| **Version** | 0.3.2 |
| **Authors** | Gerald Bauer |
| **License** | Public Domain |
| **Ruby** | >= 3.1.0 |

webget gem - a web (go get) crawler incl. web cache

**Dependencies:** webclient (>= 0.2.0), csvreader (>= 1.2.4), cocos (>= 0)

## [webmock](https://github.com/bblimke/webmock)

| | |
|---|---|
| **Version** | 3.26.1 |
| **Authors** | Bartosz Blimke |
| **License** | MIT |
| **Ruby** | >= 2.6 |

Library for stubbing HTTP requests in Ruby.

WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.

**Dependencies:** addressable (>= 2.8.0), crack (>= 0.3.2), hashdiff (>= 0.4.0, < 2.0.0)

## [webrick](https://github.com/ruby/webrick)

| | |
|---|---|
| **Version** | 1.9.2 |
| **Authors** | TAKAHASHI Masayoshi, GOTOU YUUZOU, Eric Wong |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.4.0 |

HTTP server toolkit

WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.

## [webrobots](https://github.com/knu/webrobots)

| | |
|---|---|
| **Version** | 0.1.2 |
| **Authors** | Akinori MUSHA |
| **License** | 2-clause BSDL |

A Ruby library to help write robots.txt compliant web robots

This library helps write robots.txt compliant web robots in Ruby.

## [websocket](http://github.com/imanel/websocket-ruby)

| | |
|---|---|
| **Version** | 1.2.11 |
| **Authors** | Bernard Potocki |
| **License** | MIT |
| **Ruby** | >= 2.0 |

Universal Ruby library to handle WebSocket protocol

## [websocket-client-simple](https://github.com/ruby-jp/websocket-client-simple)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Sho Hashimoto, Yusuke Nakamura |
| **License** | MIT |
| **Ruby** | >= 2.6.9 |

Simple WebSocket Client for Ruby

**Dependencies:** websocket (>= 0), event_emitter (>= 0), mutex_m (>= 0), base64 (>= 0)

## [websocket-driver](https://github.com/faye/websocket-driver-ruby)

| | |
|---|---|
| **Version** | 0.8.0 |
| **Authors** | James Coglan |
| **License** | Apache-2.0 |

WebSocket protocol handler with pluggable I/O

**Dependencies:** base64 (>= 0), websocket-extensions (>= 0.1.0)

## [websocket-extensions](https://github.com/faye/websocket-extensions-ruby)

| | |
|---|---|
| **Version** | 0.1.5 |
| **Authors** | James Coglan |
| **License** | Apache-2.0 |

Generic extension manager for WebSocket connections

## [wharel](https://github.com/shioyama/wharel)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Chris Salzberg |
| **License** | MIT |
| **Ruby** | >= 2.2.9 |

Arel + Where = Wharel

Use arel predicates directly from where.

**Dependencies:** activerecord (>= 5, < 7)

## [whenever](https://github.com/javan/whenever)

| | |
|---|---|
| **Version** | 1.1.2 |
| **Authors** | Javan Makhmali |
| **License** | MIT |
| **Ruby** | >= 1.9.3 |

Cron jobs in ruby.

Clean ruby syntax for writing and deploying cron jobs.

**Dependencies:** chronic (>= 0.6.3)

## [whois](https://whoisrb.org/)

| | |
|---|---|
| **Version** | 6.0.3 |
| **Authors** | Simone Carletti |
| **License** | MIT |
| **Ruby** | >= 3.0 |

An intelligent pure Ruby WHOIS client and parser.

Whois is an intelligent WHOIS client and parser written in pure Ruby. It can query registry data for IPv4, IPv6 and top level domains, and parse the responses into easy-to-use Ruby objects via the whois-parser library.

## [whois-parser](https://whoisrb.org/)

| | |
|---|---|
| **Version** | 2.0.0 |
| **Authors** | Simone Carletti |
| **License** | MIT |
| **Ruby** | >= 2.3 |

A pure Ruby WHOIS parser.

Whois Parser is a WHOIS parser written in pure Ruby. It can parse and convert responses into easy-to-use Ruby objects.

**Dependencies:** whois (>= 4.1.0), activesupport (>= 4)

## [wicked_pdf](https://github.com/mileszs/wicked_pdf)

| | |
|---|---|
| **Version** | 2.8.2 |
| **Authors** | Miles Z. Sterrett, David Jones |
| **License** | MIT |
| **Ruby** | >= 2.2 |

PDF generator (from HTML) gem for Ruby on Rails

Wicked PDF uses the shell utility wkhtmltopdf to serve a PDF file to a user from HTML. In other words, rather than dealing with a PDF generation DSL of some sort, you simply write an HTML view as you would normally, and let Wicked take care of the hard stuff.

**Dependencies:** activesupport (>= 0), ostruct (>= 0)

## [wirb](https://github.com/janlelis/wirb)

| | |
|---|---|
| **Version** | 3.0.0 |
| **Authors** | Jan Lelis |
| **License** | MIT |
| **Ruby** | >= 3.0, < 5.0 |

Add syntax highlighting for inspected Ruby objects

WIRB adds syntax highlighting for inspected Ruby objects - from core and default gems

**Dependencies:** paint (>= 0.9, < 4.0)

## [wisper](https://github.com/krisleech/wisper)

| | |
|---|---|
| **Version** | 2.0.1 |
| **Authors** | Kris Leech |
| **License** | MIT |

A micro library providing objects with Publish-Subscribe capabilities

A micro library providing objects with Publish-Subscribe capabilities. Both synchronous (in-process) and asynchronous (out-of-process) subscriptions are supported. Check out the Wiki for articles, guides and examples: https://github.com/krisleech/wisper/wiki

## [with_advisory_lock](https://github.com/ClosureTree/with_advisory_lock)

| | |
|---|---|
| **Version** | 7.5.0 |
| **Authors** | Matthew McEachen, Abdelkader Boudih |
| **License** | MIT |
| **Ruby** | >= 3.3.0 |

Advisory locking for ActiveRecord

**Dependencies:** activerecord (>= 7.2), zeitwerk (>= 2.7)

## [with_model](https://github.com/Casecommons/with_model)

| | |
|---|---|
| **Version** | 2.2.0 |
| **Authors** | Case Commons, LLC, Grant Hutchins, Andrew Marshall |
| **License** | MIT |
| **Ruby** | >= 3.1 |

Dynamically build a model within an RSpec context

**Dependencies:** activerecord (>= 7.0)

## [with_progress](http://github.com/marcandre/with_progress)

| | |
|---|---|
| **Version** | 1.0.1 |
| **Authors** | Marc-Andre Lafortune |
| **License** | MIT |

progressbar for enumerables

**Dependencies:** ruby-progressbar (~> 1.4)

## [wmi-lite](https://github.com/chef/wmi-lite)

| | |
|---|---|
| **Version** | 1.0.7 |
| **Authors** | Adam Edwards |
| **License** | Apache-2.0 |

A lightweight utility library for accessing basic WMI (Windows Management Instrumentation) functionality on Windows

A lightweight utility over win32ole for accessing basic WMI (Windows Management Instrumentation) functionality in the Microsoft Windows operating system. It has no runtime dependencies other than Ruby, so it can be used without concerns around dependency issues.

## [wombat](http://felipecsl.github.com/wombat)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Felipe Lima |
| **License** | MIT |
| **Ruby** | >= 1.9 |

Ruby DSL to scrape web pages

Generic Web crawler with a DSL that parses structured data from web pages

**Dependencies:** activesupport (>= 0), mechanize (~> 2.14.0), rest-client (>= 0)

## [word_wrap](https://github.com/pazdera/word_wrap)

| | |
|---|---|
| **Version** | 1.0.0 |
| **Authors** | Radek Pazdera |
| **License** | MIT |

Simple tool for word-wrapping text

As simple as it gets CLI tool for word-wrapping plain-text. You can also use the library in your Ruby scripts. Check out the sources for details.

## [word_wrapper](https://github.com/scpike/word-wrapping/tree/master/ruby)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Stephen Pike |
| **License** | bsd |

Pure ruby word wrapping

Word wrapping implementation in ruby. Includes a naive greedy algorithm (fast) and Knuth's minimum raggedness algorithm from TeX (slower for long texts).

## [wordy](https://github.com/citrus/wordy)

| | |
|---|---|
| **Version** | 1.1.0 |
| **Authors** | Spencer Steffen |
| **Ruby** | >= 1.9 |

Written to help us create sample data for our applications, Wordy speaks in lorem ipsum. You can ask Wordy for paragraphs, sentences or words.

Written to help us create sample data for our applications, Wordy speaks in lorem ipsum. You can ask Wordy for paragraphs, sentences or words. Please see documentation for more information.

## [workbush](https://github.com/ogirginc/workbush)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Oğulcan Girginç |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Manage git worktrees with automatic file copying and setup commands

Workbush simplifies git worktree creation by automatically copying dependencies, configuration files, and running setup commands based on a simple YAML configuration.

**Dependencies:** thor (~> 1.3)

## [wt_activerecord_index_spy](https://github.com/fabioperrella/wt_activerecord_index_spy)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Fabio Perrella |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

It checks if queries use an index

It uses activerecord's notifications to run an explain query on each query that uses a WHERE statement

**Dependencies:** activerecord (>= 4.0), activesupport (>= 4.0), rspec (~> 3.0), sorbet-runtime (>= 0)

## [wxruby3](https://github.com/mcorino/wxRuby3)

| | |
|---|---|
| **Version** | 1.6.1 |
| **Authors** | Martin Corino |
| **License** | MIT |
| **Ruby** | >= 2.5 |

wxWidgets extension for Ruby

wxRuby3 is a Ruby library providing an extension for the wxWidgets C++ UI framework

**Dependencies:** nokogiri (~> 1.12), rake (>= 0), minitest (~> 5.15), test-unit (~> 3.5), plat4m (~> 1.1)

## [x](https://sferik.github.io/x-ruby)

| | |
|---|---|
| **Version** | 0.18.0 |
| **Authors** | Erik Berlin |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A Ruby interface to the X API.

**Dependencies:** base64 (>= 0.2)

## [xdg](https://alchemists.io/projects/xdg)

| | |
|---|---|
| **Version** | 9.5.0 |
| **Authors** | Brooke Kuhlmann |
| **License** | Hippocratic-2.1 |
| **Ruby** | >= 3.4 |

A XDG Base Directory Specification implementation.

## [xml-simple](https://github.com/maik/xml-simple)

| | |
|---|---|
| **Version** | 1.1.9 |
| **Authors** | Maik Schmidt |
| **License** | MIT |

A simple API for XML processing.

**Dependencies:** rexml (>= 0)

## [xmlrpc](https://github.com/ruby/xmlrpc)

| | |
|---|---|
| **Version** | 0.3.3 |
| **Authors** | SHIBATA Hiroshi, Sutou Kouhei |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.3 |

XMLRPC is a lightweight protocol that enables remote procedure calls over HTTP.

**Dependencies:** webrick (>= 0)

## [xmpp4r](http://home.gna.org/xmpp4r/)

| | |
|---|---|
| **Version** | 0.5 |
| **Authors** | Lucas Nussbaum, Stephan Maka, Glenn Rempe |
| **Ruby** | >= 1.8.4 |

XMPP4R is an XMPP/Jabber library for Ruby.

## [xpath](https://github.com/teamcapybara/xpath)

| | |
|---|---|
| **Version** | 3.2.0 |
| **Authors** | Jonas Nicklas |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Generate XPath expressions from Ruby

XPath is a Ruby DSL for generating XPath expressions

**Dependencies:** nokogiri (~> 1.8)

## [xrb](https://github.com/ioquatix/xrb)

| | |
|---|---|
| **Version** | 0.11.2 |
| **Authors** | Samuel Williams, Adam Daniels, Cyril Roelandt, Jean Boussier |
| **License** | MIT |
| **Ruby** | >= 3.2 |

A fast native templating system that compiles directly to Ruby code.

## [xxhash](http://github.com/nashby/xxhash)

| | |
|---|---|
| **Version** | 0.7.0 |
| **Authors** | Vasiliy Ermolovich |
| **License** | MIT |

Ruby wrapper for xxHash lib

## [yabeda](https://github.com/yabeda-rb/yabeda)

| | |
|---|---|
| **Version** | 0.14.0 |
| **Authors** | Andrey Novikov |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Extensible framework for collecting metric for your Ruby application

Collect statistics about how your application is performing with ease. Export metrics to various monitoring systems.

**Dependencies:** anyway_config (>= 1.0, < 3), concurrent-ruby (>= 0), dry-initializer (>= 0)

## [yabeda-prometheus](https://github.com/yabeda-rb/yabeda-prometheus)

| | |
|---|---|
| **Version** | 0.9.1 |
| **Authors** | Andrey Novikov |
| **License** | MIT |
| **Ruby** | >= 2.3 |

Extensible Prometheus exporter for your application

**Dependencies:** prometheus-client (>= 3.0, < 5.0), yabeda (~> 0.10), rack (>= 0)

## [yabeda-puma-plugin](http://github.com/yabeda-rb/yabeda-puma-plugin)

| | |
|---|---|
| **Version** | 0.9.0 |
| **Authors** | Salahutdinov Dmitry |
| **License** | MIT |

Puma web server plugin for collecting puma metrics with Yabeda framework.

Extends Yabeda metrics with puma web server values by using puma plugin

**Dependencies:** yabeda (~> 0.5), puma (>= 0), json (>= 0)

## [yabeda-rails](https://github.com/yabeda-rb/yabeda-rails)

| | |
|---|---|
| **Version** | 0.11.0 |
| **Authors** | Andrey Novikov |
| **License** | MIT |
| **Ruby** | >= 2.5 |

Extensible metrics for monitoring Ruby on Rails application

Easy collecting your Rails apps metrics

**Dependencies:** activesupport (>= 0), anyway_config (>= 1.3, < 3), railties (>= 0), yabeda (~> 0.8)

## [yabeda-sidekiq](https://github.com/yabeda-rb/yabeda-sidekiq)

| | |
|---|---|
| **Version** | 0.12.0 |
| **Authors** | Andrey Novikov |
| **License** | MIT |

Extensible Prometheus exporter for monitoring your Sidekiq

Prometheus exporter for easy collecting most important of your Sidekiq metrics

**Dependencies:** anyway_config (>= 1.3, < 3), sidekiq (>= 0), yabeda (~> 0.6)

## [yajl](https://github.com/zachaysan/yajl)

| | |
|---|---|
| **Version** | 0.3.4 |
| **Authors** | Zach Aysan |
| **License** | MIT |

Yet Another JSON Logger

Rather than streaming logs through a UDP connection this logger favors a simplier method: store things locally and retrieve them when your servers are not busy.

## [yajl-ruby](https://github.com/brianmario/yajl-ruby)

| | |
|---|---|
| **Version** | 1.4.3 |
| **Authors** | Brian Lopez, Lloyd Hilaiel |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

Ruby C bindings to the excellent Yajl JSON stream-based parser library.

## [yake](https://github.com/amancevice/yake)

| | |
|---|---|
| **Version** | 1.2.1 |
| **Authors** | Alexander Mancevice |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

Rake-like DSL for declaring AWS Lambda function handlers

**Dependencies:** ostruct (>= 0), logger (>= 0)

## [yaml](https://github.com/ruby/yaml)

| | |
|---|---|
| **Version** | 0.3.0 |
| **Authors** | Aaron Patterson, SHIBATA Hiroshi |
| **License** | Ruby, BSD-2-Clause |

YAML Ain't Markup Language

## [yard](http://yardoc.org)

| | |
|---|---|
| **Version** | 0.9.38 |
| **Authors** | Loren Segal |
| **License** | MIT |

Documentation tool for consistent and usable documentation in Ruby.

YARD is a documentation generation tool for the Ruby programming language. It enables the user to generate consistent, usable documentation that can be exported to a number of formats very easily, and also supports extending for custom Ruby constructs such as custom class level definitions.

## [yard-activesupport-concern](https://github.com/digitalcuisine/yard-activesupport-concern)

| | |
|---|---|
| **Version** | 0.0.1 |
| **Authors** | Olivier Lance @ Digital cuisine |
| **License** | MIT |

A YARD plugin to handle modules using ActiveSupport::Concern

This is a YARD extension that brings support for modules making use of ActiveSupport::Concern. It makes YARD parse docstrings inside included and class_methods blocks and generate the proper documentation for them.

**Dependencies:** yard (>= 0.8)

## [yard-junk](https://github.com/zverok/yard-junk)

| | |
|---|---|
| **Version** | 0.0.10 |
| **Authors** | Victor Shepelev |
| **License** | MIT |
| **Ruby** | >= 2.7.0 |

Get rid of the junk in your YARD docs

YardJunk is structured logger/error validator plugin for YARD documentation gem.

**Dependencies:** yard (>= 0), backports (>= 3.18), rainbow (>= 0), ostruct (>= 0)

## [yard-lint](https://github.com/mensfeld/yard-lint)

| | |
|---|---|
| **Version** | 1.4.0 |
| **Authors** | Maciej Mensfeld |
| **License** | MIT |
| **Ruby** | >= 3.2.0 |

YARD documentation linter and validator

A comprehensive linter for YARD documentation that checks for undocumented code, invalid tags, incorrect tag ordering, and more.

**Dependencies:** yard (~> 0.9), zeitwerk (~> 2.6)

## [yard-markdown](https://poshtui.com)

| | |
|---|---|
| **Version** | 0.5.0 |
| **Authors** | Stanislav (Stas) Katkov |
| **License** | MIT |
| **Ruby** | >= 2.6.0 |

yard plugin to generate markdown documentation

yard plugin to generate markdown documentation for gems

**Dependencies:** yard (>= 0), csv (>= 0)

## [yard-solargraph](https://solargraph.org)

| | |
|---|---|
| **Version** | 0.1.0 |
| **Authors** | Fred Snyder |
| **Ruby** | >= 2.6 |

A YARD extension for documenting Solargraph tags.

**Dependencies:** yard (~> 0.9)

## [yardstick](https://github.com/dkubb/yardstick)

| | |
|---|---|
| **Version** | 0.9.9 |
| **Authors** | Dan Kubb |
| **License** | MIT |

A tool for verifying YARD documentation coverage

Measure YARD documentation coverage

**Dependencies:** yard (~> 0.8, >= 0.8.7.2)

## [youplot](https://github.com/red-data-tools/YouPlot)

| | |
|---|---|
| **Version** | 0.4.6 |
| **Authors** | kojix2 |
| **License** | MIT |
| **Ruby** | >= 2.5.0 |

A command line tool for Unicode Plotting

**Dependencies:** csv (>= 0), unicode_plot (>= 0.0.5)

## [zeitwerk](https://github.com/fxn/zeitwerk)

| | |
|---|---|
| **Version** | 2.7.4 |
| **Authors** | Xavier Noria |
| **License** | MIT |
| **Ruby** | >= 3.2 |

Efficient and thread-safe constant autoloader

Zeitwerk implements constant autoloading with Ruby semantics. Each gem and application may have their own independent autoloader, with its own configuration, inflector, and logger. Supports autoloading, reloading, and eager loading.

## [zlib](https://github.com/ruby/zlib)

| | |
|---|---|
| **Version** | 3.2.2 |
| **Authors** | Yukihiro Matsumoto, UENO Katsuhiro |
| **License** | Ruby, BSD-2-Clause |
| **Ruby** | >= 2.5.0 |

Ruby interface for the zlib compression/decompression library

## [zonebie](https://github.com/alindeman/zonebie)

| | |
|---|---|
| **Version** | 0.6.1 |
| **Authors** | Andy Lindeman, Steven Harman, Patrick Van Stee |
| **License** | MIT |
| **Ruby** | >= 2.0.0 |

Zonebie prevents bugs in code that deals with timezones by randomly assigning a zone on every run

Runs your tests in a random timezone

