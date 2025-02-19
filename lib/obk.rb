# frozen_string_literal: true

# (The MIT License)
#
# SPDX-FileCopyrightText: Copyright (c) 2021-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

# Obk is a decorator that adds delays between object method calls.
#
# For more information read
# {README}[https://github.com/yegor256/obk/blob/master/README.md] file.
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2021-2025 Yegor Bugayenko
# License:: MIT
class Obk
  def initialize(origin, pause: 1000)
    @origin = origin
    @pause = pause / 1000.0
    @latest = Time.now
  end

  def method_missing(*args)
    left = @pause - (Time.now - @latest)
    sleep left if left.positive?
    mtd = args.shift
    result = if @origin.respond_to?(mtd)
      params = @origin.method(mtd).parameters
      reqs = params.count { |p| p[0] == :req }
      if params.any? { |p| p[0] == :key } && args.size > reqs
        @origin.__send__(mtd, *args[0...-1], **args.last) do |*a|
          yield(*a) if block_given?
        end
      else
        @origin.__send__(mtd, *args) do |*a|
          yield(*a) if block_given?
        end
      end
    else
      super
    end
    @latest = Time.now
    result
  end

  def respond_to?(method, include_private = false)
    @origin.respond_to?(method, include_private)
  end

  def respond_to_missing?(_method, _include_private = false)
    true
  end
end
