import jsonify

fn main() {
	jsonify.initialize(jsonify.JsonStore{
		filename : "lol",
		extension : "json"
	})
}