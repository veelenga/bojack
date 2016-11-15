module BoJack
  module Exceptions
    class Runtime < Exception; end
    class Fatal < Exception; end

    class CloseConnection < Exception; end
  end
end
