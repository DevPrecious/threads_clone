// To parse this JSON data, do
//
//     final postsModel = postsModelFromJson(jsonString);

import 'dart:convert';

PostsModel postsModelFromJson(String str) => PostsModel.fromJson(json.decode(str));

String postsModelToJson(PostsModel data) => json.encode(data.toJson());

class PostsModel {
    int? id;
    String? body;
    String? image;
    String? createdAt;
    User? user;
    bool? isLiked;
    int? likes;
    List<Comment>? comments;

    PostsModel({
        this.id,
        this.body,
        this.image,
        this.createdAt,
        this.user,
        this.isLiked,
        this.likes,
        this.comments,
    });

    factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        id: json["id"],
        body: json["body"],
        image: json["image"],
        createdAt: json["created_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isLiked: json["is_liked"],
        likes: json["likes"],
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "image": image,
        "created_at": createdAt,
        "user": user?.toJson(),
        "is_liked": isLiked,
        "likes": likes,
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    };
}

class Comment {
    int? userId;
    int? threadId;
    String? body;
    String? createdAt;
    List<Subcomment>? subcomment;

    Comment({
        this.userId,
        this.threadId,
        this.body,
        this.createdAt,
        this.subcomment,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"],
        threadId: json["thread_id"],
        body: json["body"],
        createdAt: json["created_at"],
        subcomment: json["subcomment"] == null ? [] : List<Subcomment>.from(json["subcomment"]!.map((x) => Subcomment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "thread_id": threadId,
        "body": body,
        "created_at": createdAt,
        "subcomment": subcomment == null ? [] : List<dynamic>.from(subcomment!.map((x) => x.toJson())),
    };
}

class Subcomment {
    int? userId;
    int? commentId;
    String? body;
    String? createdAt;

    Subcomment({
        this.userId,
        this.commentId,
        this.body,
        this.createdAt,
    });

    factory Subcomment.fromJson(Map<String, dynamic> json) => Subcomment(
        userId: json["user_id"],
        commentId: json["comment_id"],
        body: json["body"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "comment_id": commentId,
        "body": body,
        "created_at": createdAt,
    };
}

class User {
    int? id;
    String? name;
    String? username;
    String? email;
    dynamic emailVerifiedAt;
    dynamic profilePath;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.profilePath,
        this.createdAt,
        this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        profilePath: json["profilePath"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "profilePath": profilePath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

