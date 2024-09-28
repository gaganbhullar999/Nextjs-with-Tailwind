import mongoose from "mongoose";

const uri = 'mongodb+srv://pawn:cEkskdUgC1wI14Fz@cluster0.fomr4q9.mongodb.net/production?retryWrites=true&w=majority&appName=Cluster0'

let cached = global.mongoose;

if (!cached) {
	cached = global.mongoose = { conn: null, promise: null };
}

async function connectToDatabase() {
	if (cached.conn) {
		return cached.conn;
	}

	if (!cached.promise) {
		cached.promise = mongoose.connect(uri)
	}
	cached.conn = await cached.promise;
	return cached.conn;
}

export default connectToDatabase;