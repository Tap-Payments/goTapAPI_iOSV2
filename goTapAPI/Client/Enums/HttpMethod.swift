public class HttpMethod: Enum {

	public static let Get = HttpMethod(rawValue: 0)
	public static let Post = HttpMethod(rawValue:1)
	public static let Head = HttpMethod(rawValue:2)

	internal var stringRepresentation: String {

			if self == HttpMethod.Get {

			return Constants.Value.GET
		}
		else  if self == HttpMethod.Post {

			return Constants.Value.POST
		}
		else  if self == HttpMethod.Head {

			return Constants.Value.HEAD
		}
		else {

			return String.tap_empty
		}
	}
}
