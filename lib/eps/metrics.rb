module Eps
  class Metrics
    attr_reader :errors

    def initialize(actual, estimated)
      @errors = actual.zip(estimated).map { |yi, yi2| yi - yi2 }
    end

    def all
      {
        rmse: rmse,
        mae: mae,
        me: me
      }
    end

    private

    def me
      mean(errors)
    end

    def mae
      mean(errors.map { |v| v.abs })
    end

    def mse
      mean(errors.map { |v| v**2 })
    end

    def rmse
      Math.sqrt(mse)
    end

    def mallows_cp
      (sse / mse) - (data_point_count - 2p)
    end

    def mean(arr)
      arr.inject(0, &:+) / arr.size.to_f
    end
  end
end
