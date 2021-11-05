public class HttpMethod: goTapAPI.Enum {

	public static let Get = goTapAPI.HttpMethod(rawValue: 0)
	public static let Post = goTapAPI.HttpMethod(rawValue:1)
	public static let Head = goTapAPI.HttpMethod(rawValue:2)

	internal var stringRepresentation: String {

			if self == HttpMethod.Get {

			return goTapAPI.Constants.Value.GET
		}
		else  if self == HttpMethod.Post {

			return goTapAPI.Constants.Value.POST
		}
		else  if self == HttpMethod.Head {

			return goTapAPI.Constants.Value.HEAD
		}
		else {

			return String.tap_empty
		}
	}
}
