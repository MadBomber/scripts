#!/usr/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true
# warn_indent: true
##########################################################
###
##  File: mock_web_app.rb
##  Desc: An API testing endpoint that always returns 200
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

require 'amazing_print' # Pretty print Ruby objects with proper indentation and colors
require 'logger'        # STDLIB
require 'sinatra'       # Classy web-development dressed in a DSL

before do
  headers             = request.env.select { |k, v| k.start_with?('HTTP_') }
  @headers_formatted  = headers.map { |k, v| ["#{k.sub(/^HTTP_/, '').split('_').map(&:capitalize).join('-')}", v] }.to_h
  @url                = request.url
  @params_formatted   = params.to_h
end

def format_response(body_table)
  headers_table = @headers_formatted.map { |k, v| "<tr><td>#{k}</td><td>#{v}</td></tr>" }.join("\n")
  params_table  = @params_formatted.map { |k, v| "<tr><td>#{k}</td><td>#{v}</td></tr>" }.join("\n")
  
  response.headers['Content-Type'] = 'text/html'
  
  status 200
  body <<~HTML
    <h1>Mock Web App</h1>
    <p>By: MadBomber</p>

    <h2>Received ...</h2>

    <h3>Headers:</h3>
    <table>#{headers_table}</table>

    <h3>URL:</h3>
    <p>#{@url}</p>

    <h3>Params:</h3>
    <table>#{params_table}</table>

    <h3>Body:</h3>
    #{body_table}
  HTML
end

logger            = Logger.new('mock_web_app.log')
logger.formatter  = proc do |severity, datetime, progname, msg|
  { severity: severity, timestamp: datetime.utc.iso8601, message: msg }.to_json + "\n"
end

get '/*' do
  logger.info({ method: 'GET', url: request.url, params: params, headers: request.env })
  format_response('')
end

post '/*' do
  body_table = "<table><tr><td>#{ap JSON.parse(request.body.read)}</td></tr></table>"
  logger.info({ method: 'POST', url: request.url, params: params, headers: request.env, body: request.body.read })
  format_response(body_table)
end

put '/*' do
  body_table = "<table><tr><td>#{ap JSON.parse(request.body.read)}</td></tr></table>"
  logger.info({ method: 'PUT', url: request.url, params: params, headers: request.env, body: request.body.read })
  format_response(body_table)
end

patch '/*' do
  body_table = "<table><tr><td>#{ap JSON.parse(request.body.read)}</td></tr></table>"
  logger.info({ method: 'PATCH', url: request.url, params: params, headers: request.env, body: request.body.read })
  format_response(body_table)
end

delete '/*' do
  logger.info({ method: 'DELETE', url: request.url, params: params, headers: request.env })
  format_response('')
end

