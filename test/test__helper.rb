# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2021-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

$stdout.sync = true

require 'simplecov'
SimpleCov.external_at_exit = true
SimpleCov.start

require 'simplecov-cobertura'
SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter

require 'minitest/autorun'

require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
