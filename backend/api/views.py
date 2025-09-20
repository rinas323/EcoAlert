from rest_framework import generics
from django.core.mail import EmailMultiAlternatives
from .models import Complaint
from .serializers import ComplaintSerializer

MUNICIPALITY_EMAILS = {
    "Calicut": "farispalayi@gmail.com",
    "Kochi": "farispalayi@gmail.com",
    "Trivandrum": "farispalayi@gmail.com",
}

class ComplaintCreate(generics.CreateAPIView):
    queryset = Complaint.objects.all()
    serializer_class = ComplaintSerializer

    def perform_create(self, serializer):
        complaint = serializer.save()
        municipality_name = complaint.municipality
        email_to = MUNICIPALITY_EMAILS.get(municipality_name)

        if email_to:
            subject = f"New Complaint Submitted for {municipality_name}"

            # Plain text version (fallback)
            text_content = f"""
New complaint has been submitted.

Municipality: {municipality_name}
Title: {complaint.title}
Description: {complaint.description}
Latitude: {complaint.latitude}
Longitude: {complaint.longitude}
Waste Type: {complaint.waste_type}
Submitted By: {complaint.name}
Contact: {complaint.contact}
Anonymous: {complaint.is_anonymous}
Video: {complaint.is_video}
Timestamp: {complaint.created_at}
"""

            # HTML version
            html_content = f"""
<html>
  <body>
    <h2>New Complaint Submitted</h2>
    <p><strong>Municipality:</strong> {municipality_name}</p>
    <p><strong>Title:</strong> {complaint.title}</p>
    <p><strong>Description:</strong><br>{complaint.description}</p>
    <p><strong>Latitude:</strong> {complaint.latitude}</p>
    <p><strong>Longitude:</strong> {complaint.longitude}</p>
    <p><strong>Waste Type:</strong> {complaint.waste_type}</p>
    <p><strong>Submitted By:</strong> {complaint.name}</p>
    <p><strong>Contact:</strong> {complaint.contact}</p>
    <p><strong>Anonymous:</strong> {complaint.is_anonymous}</p>
    <p><strong>Video:</strong> {complaint.is_video}</p>
    <p><strong>Timestamp:</strong> {complaint.created_at}</p>
  </body>
</html>
"""

            msg = EmailMultiAlternatives(
                subject=subject,
                body=text_content,
                from_email=None,  # uses DEFAULT_FROM_EMAIL
                to=[email_to]
            )
            msg.attach_alternative(html_content, "text/html")

            if complaint.image:
                msg.attach_file(complaint.image.path)

            msg.send()