class Reviewer {
  final String profile;
  final String name;

  Reviewer({required this.profile, required this.name});

  Map<String, dynamic> toJson() {
    return {
      'profile': profile,
      'name': name,
    };
  }

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return Reviewer(
      profile: json['profile'],
      name: json['name'],
    );
  }
}

class Rate {
  final double value;

  Rate({required this.value});

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      value: json['value'],
    );
  }
}

class Review {
  final String id; 
  final String description;
  final Rate rate;
  final Reviewer reviewer;
  final List<Reply> replies;
  final DateTime date;

  Review({
    required this.id, 
    required this.description,
    required this.rate,
    required this.reviewer,
    required this.replies,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'description': description,
      'rate': rate.toJson(),
      'reviewer': reviewer.toJson(),
      'replies': replies.map((reply) => reply.toJson()).toList(),
      'date': date.toIso8601String(),
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'], 
      description: json['description'],
      rate: Rate.fromJson(json['rate']),
      reviewer: Reviewer.fromJson(json['reviewer']),
      replies: (json['replies'] as List)
          .map((reply) => Reply.fromJson(reply))
          .toList(),
      date: DateTime.parse(json['date']),
    );
  }
}


class Reply {
  final String content;
  final Reviewer replier;
  final DateTime date;

  Reply({
    required this.content,
    required this.replier,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'replier': replier.toJson(),
      'date': date.toIso8601String(),
    };
  }

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      content: json['content'],
      replier: Reviewer.fromJson(json['replier']),
      date: DateTime.parse(json['date']),
    );
  }
}



