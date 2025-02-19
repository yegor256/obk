# frozen_string_literal: true

# (The MIT License)
#
# SPDX-FileCopyrightText: Copyright (c) 2021-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'json'
require_relative '../lib/obk'

# Obk test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2021-2025 Yegor Bugayenko
# License:: MIT
class ObkTest < Minitest::Test
  def test_simple
    obj = Object.new
    def obj.read(foo)
      foo
    end
    obj = Obk.new(obj, pause: 100)
    start = Time.now
    assert_equal(42, obj.read(42))
    assert_equal(42, obj.read(42))
    stop = Time.now
    assert(stop - start > 0.1)
  end

  def test_works_with_optional_arguments
    obj = Object.new
    def obj.foo(first, _second, ext1: 'a', ext2: 'b')
      first + ext1 + ext2
    end
    synced = Obk.new(obj, pause: 10)
    assert_equal('.xy', synced.foo('.', {}, ext1: 'x', ext2: 'y'))
    assert_equal('fzb', synced.foo('f', {}, ext1: 'z'))
    assert_equal('-ab', synced.foo('-', {}))
  end

  def test_works_with_default_value
    obj = Object.new
    def obj.foo(first, second = 42)
      first + second
    end
    synced = Obk.new(obj, pause: 10)
    assert_equal(15, synced.foo(7, 8))
    assert_equal(43, synced.foo(1))
  end
end
