require 'spec_helper'

describe DeepClone do
  describe '.clone' do
    it 'should not clone an integer' do
      # Integers aren't "deep cloned, so their object ID should remaiin the
      # same.
      i1 = 1
      i2 = DeepClone.clone i1

      expect(i1).to eql(i2)
    end

    it 'should not clone a Bignum' do
      bignum = 1e20.to_i
      expect(DeepClone.clone(bignum).object_id).to eql(bignum.object_id)
    end

    it 'should not clone a float' do
      float = 42.0
      expect(DeepClone.clone(float).object_id).to eql(float.object_id)
    end

    it 'should not clone nil' do
      nothing = nil
      expect(DeepClone.clone(nothing).object_id).to eql(nothing.object_id)
    end

    it 'should not clone true' do
      yes = true
      expect(DeepClone.clone(yes).object_id).to eql(yes.object_id)
    end

    it 'should not clone false' do
      no = false
      expect(DeepClone.clone(no).object_id).to eql(no.object_id)
    end

    it 'should not clone a Symbol' do
      symbol = :symbol
      expect(DeepClone.clone(symbol).object_id).to eql(symbol.object_id)
    end

    it 'should not clone a non literal a Symbol' do
      sym = "foo".to_sym
      expect(DeepClone.clone(sym).object_id).to eql(sym.object_id)
    end

    it 'should clone a string' do
      s1 = "Ruby is awesome!"
      s2 = DeepClone.clone s1

      expect(s1).to     eq(s2)
      expect(s1).to_not eql(s2.object_id)
    end

    it 'should clone a Time' do
      require 'time'

      time = Time.now
      expect(DeepClone.clone(time).object_id).to_not eql(time.object_id)
    end

    it 'should clone a DateTime' do
      require 'time'

      time = DateTime.now
      expect(DeepClone.clone(time).object_id).to_not eql(time.object_id)
    end

    it 'should clone a Date' do
      require 'date'

      date = Date.today
      expect(DeepClone.clone(date).object_id).to_not eql(date.object_id)
    end

    it 'should not clone a literal Regexp' do
      regex = /okay/
      expect(DeepClone.clone(regex).object_id).to eql(regex.object_id)
    end

    it 'should clone a non-literal Regexp' do
      skip "/okay/.clone is not normally allowed..." do
        regex = Regexp.new('okay')
        expect(DeepClone.clone(regex).object_id).to_not eql(regex.object_id)
      end
    end

    it 'should not clone a Numeric' do
      num = Numeric.new
      expect(DeepClone.clone(num).object_id).to eql(num.object_id)
    end

    it 'should clone a hash with non literal symbol keys' do
      foo = {}
      foo["foo".to_sym] = "foo"
      foo["bar".to_sym] = "bar"

      clone = DeepClone.clone foo
      expect(clone.object_id).to_not eql(foo)
      expect(clone).to eql(foo)
    end

    it 'should clone an object with a hash property' do
      class ClassWithHash
        attr_reader :h

        def initialize(h)
          @h = h
        end
      end

      foo = {}
      foo["foo".to_sym] = "foo"
      foo["bar".to_sym] = "bar"

      obj = ClassWithHash.new foo

      clone = DeepClone.clone obj
      expect(clone.object_id).to_not eql(obj)
      expect(clone.h.object_id).to_not eql(obj.h.object_id)
      expect(clone.h).to eql(obj.h)
      expect(clone.h).to eql(foo)
    end

    it 'should clone a Proc' do
      p = proc { true }
      clone = DeepClone.clone(p)
      expect(clone.object_id).to_not eql(p.object_id)
      expect(clone.call).to eq(true)
    end
  end
end
