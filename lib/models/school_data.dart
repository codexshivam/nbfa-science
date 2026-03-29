import 'package:flutter/material.dart';

class SchoolData {
  const SchoolData({
    required this.metadata,
    required this.about,
    required this.calendar,
    required this.liveStats,
    required this.academicGroups,
    required this.documents,
    required this.galleryImages,
    required this.contactInfo,
    required this.facilityHighlights,
    required this.faq,
    required this.testimonials,
    required this.facultyDepartments,
    required this.scholarshipScheme,
  });

  final SchoolMetadata metadata;
  final DetailedAbout about;
  final AcademicCalendar calendar;
  final List<LiveStat> liveStats;
  final List<AcademicGroup> academicGroups;
  final List<DocumentItem> documents;
  final List<GalleryImage> galleryImages;
  final ContactInfo contactInfo;
  final List<FacilityHighlight> facilityHighlights;
  final List<FaqItem> faq;
  final List<Testimonial> testimonials;
  final List<FacultyDepartment> facultyDepartments;
  final ScholarshipScheme scholarshipScheme;

  factory SchoolData.fromJson(Map<String, dynamic> json) {
    return SchoolData(
      metadata: SchoolMetadata.fromJson(
        json['school_metadata'] as Map<String, dynamic>,
      ),
      about: DetailedAbout.fromJson(
        json['detailed_about'] as Map<String, dynamic>,
      ),
      calendar: AcademicCalendar.fromJson(
        json['academic_calendar_detailed'] as Map<String, dynamic>,
      ),
      liveStats: (json['live_stats'] as List<dynamic>)
          .map((entry) => LiveStat.fromJson(entry as Map<String, dynamic>))
          .toList(),
      academicGroups: (json['academic_groups'] as List<dynamic>)
          .map((entry) => AcademicGroup.fromJson(entry as Map<String, dynamic>))
          .toList(),
      documents: (json['documents'] as List<dynamic>)
          .map((entry) => DocumentItem.fromJson(entry as Map<String, dynamic>))
          .toList(),
      galleryImages: (json['gallery_images'] as List<dynamic>)
          .map((entry) => GalleryImage.fromJson(entry as Map<String, dynamic>))
          .toList(),
      contactInfo: ContactInfo.fromJson(
        json['contact_info'] as Map<String, dynamic>,
      ),
      facilityHighlights: (json['facility_highlights'] as List<dynamic>)
          .map(
            (entry) =>
                FacilityHighlight.fromJson(entry as Map<String, dynamic>),
          )
          .toList(),
      faq: (json['faq'] as List<dynamic>)
          .map((entry) => FaqItem.fromJson(entry as Map<String, dynamic>))
          .toList(),
      testimonials: (json['testimonials'] as List<dynamic>)
          .map((entry) => Testimonial.fromJson(entry as Map<String, dynamic>))
          .toList(),
      facultyDepartments: (json['faculty_departments'] as List<dynamic>)
          .map(
            (entry) =>
                FacultyDepartment.fromJson(entry as Map<String, dynamic>),
          )
          .toList(),
      scholarshipScheme: ScholarshipScheme.fromJson(
        json['scholarship_scheme'] as Map<String, dynamic>,
      ),
    );
  }
}

class SchoolMetadata {
  const SchoolMetadata({
    required this.name,
    required this.abbreviation,
    required this.motto,
    required this.establishedBs,
    required this.affiliation,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroImageUrl,
  });

  final String name;
  final String abbreviation;
  final String motto;
  final String establishedBs;
  final String affiliation;
  final String heroTitle;
  final String heroSubtitle;
  final String heroImageUrl;

  factory SchoolMetadata.fromJson(Map<String, dynamic> json) {
    return SchoolMetadata(
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String,
      motto: json['motto'] as String,
      establishedBs: json['established_bs'] as String,
      affiliation: json['affiliation'] as String,
      heroTitle: json['hero_title'] as String,
      heroSubtitle: json['hero_subtitle'] as String,
      heroImageUrl: json['hero_image_url'] as String,
    );
  }
}

class DetailedAbout {
  const DetailedAbout({
    required this.philosophy,
    required this.coreValues,
    required this.leadership,
  });

  final String philosophy;
  final List<CoreValue> coreValues;
  final List<LeadershipMember> leadership;

  factory DetailedAbout.fromJson(Map<String, dynamic> json) {
    return DetailedAbout(
      philosophy: json['philosophy'] as String,
      coreValues: (json['core_values'] as List<dynamic>)
          .map((entry) => CoreValue.fromJson(entry as Map<String, dynamic>))
          .toList(),
      leadership: (json['leadership'] as List<dynamic>)
          .map(
            (entry) => LeadershipMember.fromJson(entry as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class LeadershipMember {
  const LeadershipMember({
    required this.name,
    required this.role,
    required this.bio,
    required this.imageUrl,
  });

  final String name;
  final String role;
  final String bio;
  final String imageUrl;

  factory LeadershipMember.fromJson(Map<String, dynamic> json) {
    return LeadershipMember(
      name: json['name'] as String,
      role: json['role'] as String,
      bio: json['bio'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
}

class CoreValue {
  const CoreValue({required this.title, required this.description});

  final String title;
  final String description;

  factory CoreValue.fromJson(Map<String, dynamic> json) {
    return CoreValue(
      title: json['title'] as String,
      description: json['desc'] as String,
    );
  }
}

class AcademicCalendar {
  const AcademicCalendar({required this.session, required this.events});

  final String session;
  final List<AcademicEvent> events;

  factory AcademicCalendar.fromJson(Map<String, dynamic> json) {
    return AcademicCalendar(
      session: json['current_session'] as String,
      events: (json['events'] as List<dynamic>)
          .map((entry) => AcademicEvent.fromJson(entry as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AcademicEvent {
  const AcademicEvent({
    required this.month,
    required this.title,
    required this.details,
  });

  final String month;
  final String title;
  final String details;

  factory AcademicEvent.fromJson(Map<String, dynamic> json) {
    return AcademicEvent(
      month: json['month'] as String,
      title: json['title'] as String,
      details: json['details'] as String,
    );
  }
}

class LiveStat {
  const LiveStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final int value;
  final String icon;

  factory LiveStat.fromJson(Map<String, dynamic> json) {
    return LiveStat(
      label: json['label'] as String,
      value: json['value'] as int,
      icon: json['icon'] as String,
    );
  }

  IconData get iconData {
    switch (icon) {
      case 'groups':
        return Icons.groups_2;
      case 'school':
        return Icons.school;
      case 'science':
        return Icons.science;
      default:
        return Icons.auto_graph;
    }
  }
}

class AcademicGroup {
  const AcademicGroup({
    required this.group,
    required this.overview,
    required this.modules,
  });

  final String group;
  final String overview;
  final List<String> modules;

  factory AcademicGroup.fromJson(Map<String, dynamic> json) {
    return AcademicGroup(
      group: json['group'] as String,
      overview: json['overview'] as String,
      modules: (json['modules'] as List<dynamic>).cast<String>(),
    );
  }
}

class DocumentItem {
  const DocumentItem({
    required this.title,
    required this.type,
    required this.size,
  });

  final String title;
  final String type;
  final String size;

  factory DocumentItem.fromJson(Map<String, dynamic> json) {
    return DocumentItem(
      title: json['title'] as String,
      type: json['type'] as String,
      size: json['size'] as String,
    );
  }

  IconData get iconData {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
        return Icons.description;
      case 'xlsx':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file;
    }
  }
}

class GalleryImage {
  const GalleryImage({required this.title, required this.url});

  final String title;
  final String url;

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }
}

class ContactInfo {
  const ContactInfo({
    required this.address,
    required this.phone,
    required this.email,
    required this.mapsPlaceholder,
  });

  final String address;
  final String phone;
  final String email;
  final String mapsPlaceholder;

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      mapsPlaceholder: json['maps_placeholder'] as String,
    );
  }
}

class FacilityHighlight {
  const FacilityHighlight({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final String icon;

  factory FacilityHighlight.fromJson(Map<String, dynamic> json) {
    return FacilityHighlight(
      title: json['title'] as String,
      description: json['desc'] as String,
      icon: json['icon'] as String,
    );
  }

  IconData get iconData {
    switch (icon) {
      case 'smart_display':
        return Icons.smart_display;
      case 'biotech':
        return Icons.biotech;
      case 'menu_book':
        return Icons.menu_book;
      default:
        return Icons.apartment;
    }
  }
}

class FaqItem {
  const FaqItem({required this.question, required this.answer});

  final String question;
  final String answer;

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }
}

class Testimonial {
  const Testimonial({
    required this.name,
    required this.batch,
    required this.achievement,
    required this.quote,
  });

  final String name;
  final String batch;
  final String achievement;
  final String quote;

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      name: json['name'] as String,
      batch: json['batch'] as String,
      achievement: json['achievement'] as String,
      quote: json['quote'] as String,
    );
  }
}

class FacultyDepartment {
  const FacultyDepartment({
    required this.department,
    required this.head,
    required this.totalStaff,
    required this.featuredLecturers,
    required this.labs,
  });

  final String department;
  final String head;
  final int totalStaff;
  final List<String> featuredLecturers;
  final List<String> labs;

  factory FacultyDepartment.fromJson(Map<String, dynamic> json) {
    return FacultyDepartment(
      department: json['dept'] as String,
      head: json['head'] as String,
      totalStaff: json['total_staff'] as int,
      featuredLecturers: (json['featured_lecturers'] as List<dynamic>? ?? [])
          .cast<String>(),
      labs: (json['labs'] as List<dynamic>? ?? []).cast<String>(),
    );
  }
}

class ScholarshipScheme {
  const ScholarshipScheme({required this.title, required this.categories});

  final String title;
  final List<ScholarshipCategory> categories;

  factory ScholarshipScheme.fromJson(Map<String, dynamic> json) {
    return ScholarshipScheme(
      title: json['title'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map(
            (entry) =>
                ScholarshipCategory.fromJson(entry as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class ScholarshipCategory {
  const ScholarshipCategory({
    required this.type,
    required this.criteria,
    required this.benefit,
  });

  final String type;
  final String criteria;
  final String benefit;

  factory ScholarshipCategory.fromJson(Map<String, dynamic> json) {
    return ScholarshipCategory(
      type: json['type'] as String,
      criteria: json['criteria'] as String,
      benefit: json['benefit'] as String,
    );
  }
}
