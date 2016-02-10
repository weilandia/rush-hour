require_relative "../test_helper"

class RequestTypeTest < Minitest::Test
  include TestHelpers
  include PayloadTestData

  def setup
    gather_data
  end


  def test_request_verb
    assert_equal "GET", RequestType.find(@request_type.id).verb
  end

  def test_top_request_type
    RequestType.create({verb: "GET"})
    RequestType.create({verb: "POST"})

    assert_equal "GET", RequestType.top
  end

  def test_all_request_types
    RequestType.create({verb: "GET"})
    RequestType.create({verb: "POST"})
    RequestType.create({verb: "DELETE"})
    RequestType.create({verb: "PUT"})

    assert_equal 4, RequestType.all_verbs.count

    expected = {"POST"=>1, "GET"=>2, "DELETE"=>1, "PUT"=>1}

    assert_equal expected, RequestType.all_verbs
  end
end
