# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2021-2026 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'json'
require 'minitest/autorun'
require_relative '../lib/obk'
require_relative '../test/test__helper'

# Obk test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2021-2026 Yegor Bugayenko
# License:: MIT
class ObkTest < Minitest::Test
  def test_simple
    plain = Object.new
    def plain.read(foo)
      foo
    end
    obj = Obk.new(plain, pause: 100)
    before = Time.now
    obj.read(42)
    obj.read(42)
    assert_operator(Time.now - before, :>, 0.1)
  end

  def test_works_with_optional_arguments
    plain = Object.new
    def plain.foo(first, _second, ext1: 'a', ext2: 'b')
      first + ext1 + ext2
    end
    synced = Obk.new(plain, pause: 10)
    assert_equal('.xy', synced.foo('.', {}, ext1: 'x', ext2: 'y'))
    assert_equal('fzb', synced.foo('f', {}, ext1: 'z'))
    assert_equal('-ab', synced.foo('-', {}))
  end

  def test_works_with_default_value
    plain = Object.new
    def plain.foo(first, second = 42)
      first + second
    end
    synced = Obk.new(plain, pause: 10)
    assert_equal(15, synced.foo(7, 8))
    assert_equal(43, synced.foo(1))
  end
end
