import 'package:instrapound/models/me_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseService {
  final String _connectionString =
      "mongodb+srv://instrapound:123456aB@cluster0.g6h8u.mongodb.net/test?retryWrites=true&w=majority&appName=Cluster0";

  final String _collectionName = "auth";

  Future<void> connectAndInsertExample() async {
    print('Connecting');
    Db db = await Db.create(_connectionString);

    try {
      await db.open();
      print("Connected to the database!");

      var collection = db.collection(_collectionName);

      // Insert example document
      await collection.insertOne({
        "name": "MHN2",
        "email": "mhn4real2@gmail.com",
        "password": "Viciu123@"
      });
      print("Document inserted successfully.");

      // Query example
      var user = await collection.findOne({"name": "John Doe"});
      print("User found: $user");
    } catch (e) {
      print("Error connecting to the database: $e");
    } finally {
      await db.close();
      print("Database connection closed.");
    }
  }

  ///get single ro current user details
  Future<dynamic> getUser({
    required String email,
    required String password,
  }) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      final user = await collection.findOne({
        "email": email,
        "password": password, // Note: Storing plain text passwords is insecure.
      });

      if (user != null) {
        return user; // Success: return null
      } else {
        return "Invalid email or password"; // Failure: return error message
      }
    } catch (e) {
      return "Error during login: $e"; // Failure: return error message
    } finally {
      await db?.close(); // Ensure the database is closed
    }
  }

  ///get All user details
  Future<List<MeModel>> getAllUser() async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      // Fetch all users and map them to MeModel instances
      final users = await collection.find().toList();
      return users.map((user) => MeModel.fromAPI(map: user)).toList();
    } catch (e) {
      print("Error fetching users: $e");
      return []; // Return an empty list on error
    } finally {
      await db?.close();
    }
  }

  ///register new user
  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required DateTime createdAt,
  }) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      final existingUser = await collection.findOne({"email": email});
      if (existingUser != null) {
        return "Email already registered"; // Failure: return error message
      }

      final writeResult = await collection.insertOne({
        "name": name,
        "email": email,
        "password": password, // Consider hashing the password for security
        "createdAt": createdAt.toIso8601String(),
      });
      // superPrint(writeResult.errmsg);
      if (writeResult.isSuccess ||
          writeResult.isSuspendedSuccess ||
          writeResult.isPartialSuccess) {
        return null; // Success: return null
      } else {
        return writeResult.errmsg ?? "Something went wrong!";
      }
    } catch (e) {
      return "Error during registration: $e"; // Failure: return error message
    } finally {
      await db?.close(); // Ensure the database is closed
    }
  }

  /// return null if there is no user, return string if there is one
  Future<String?> isEmailRegistered(String email) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      final user = await collection.findOne({"email": email});
      if (user != null) {
        //has user
        return "This email has already registered!";
      } else {
        return null;
      }
    } catch (e) {
      return "Unable to connect to the server!"; // Return error message on failure
    } finally {
      await db?.close();
    }
  }

  ///get password from input email to make login
  Future<String?> getPassword(String email) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      // Retrieve user password based on email
      final user = await collection.findOne({"email": email});
      return user?["password"] ?? "error"; // Return "error" if user is null
    } catch (e) {
      print("Database connection error: $e");
      return "Unable to connect to the server!";
    } finally {
      await db?.close(); // Ensure database connection closes
    }
  }

  /// Updates the password for a user with the specified email.
  /// Returns null if successful, or an error message if the user is not found or there's a database error.
  /// for forgot password
  Future<String?> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      // Check if user with the given email exists
      final user = await collection.findOne({"email": email});
      if (user == null) {
        return "User with the specified email not found.";
      }

      // Update the password
      final result = await collection.updateOne(
        where.eq("email", email),
        modify.set("password", newPassword),
      );

      if (result.isSuccess) {
        return null; // Password updated successfully
      } else {
        return "Password Reset failed. Please try again.";
      }
    } catch (e) {
      return "Error Resetting password: $e"; // Return error message on failure
    } finally {
      await db?.close(); // Ensure the database is closed
    }
  }

  /// Updates user data (name, email, password) for a user identified by the old email.
  /// Returns null if successful, or an error message if the user is not found or there's a database error.
  /// for profile update
  Future<String?> updateUserData({
    required String oldEmail,
    required String newName,
    required String newEmail,
    required String newPassword,
  }) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      // Check if user with the given old email exists
      final user = await collection.findOne({"email": oldEmail});
      if (user == null) {
        return "User with the specified email not found.";
      }

      // Update user data
      final result = await collection.updateOne(
        where.eq("email", oldEmail),
        modify
            .set("name", newName)
            .set("email", newEmail)
            .set("password", newPassword),
      );

      if (result.isSuccess) {
        return null; // Data updated successfully
      } else {
        return "User data update failed. Please try again.";
      }
    } catch (e) {
      return "Error updating user data: $e"; // Return error message on failure
    } finally {
      await db?.close(); // Ensure the database is closed
    }
  }
}
