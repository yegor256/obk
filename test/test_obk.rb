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

  def test_passes_no_block_with_positional_arguments
    plain = Object.new
    def plain.foo(_first)
      block_given? ? 'has block' : 'no block'
    end
    assert_equal('no block', Obk.new(plain, pause: 10).foo(1))
  end

  def test_passes_no_block_with_keyword_arguments
    plain = Object.new
    def plain.foo(_first, ext: 'a')
      block_given? ? "has #{ext}" : "no #{ext}"
    end
    assert_equal('no x', Obk.new(plain, pause: 10).foo(1, ext: 'x'))
  end

  def test_passes_block_with_positional_arguments
    plain = Object.new
    def plain.foo(first)
      block_given? ? yield(first) : 'no block'
    end
    assert_equal(8, Obk.new(plain, pause: 10).foo(7) { |x| x + 1 })
  end

  def test_passes_block_with_keyword_arguments
    plain = Object.new
    def plain.foo(first, ext: 1)
      block_given? ? yield(first + ext) : 'no block'
    end
    assert_equal(9, Obk.new(plain, pause: 10).foo(7, ext: 2) { |x| x })
  end
end
