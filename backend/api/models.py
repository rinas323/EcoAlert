import uuid
from django.db import models

class Complaint(models.Model):
    WASTE_TYPE_CHOICES = [
        ('plastic', 'Plastic'),
        ('organic', 'Organic'),
        ('metal', 'Metal'),
        ('other', 'Other'),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    title = models.CharField(max_length=255, blank=True)
    description = models.TextField(blank=True)
    latitude = models.FloatField(default=0.0)
    longitude = models.FloatField(default=0.0)
    created_at = models.DateTimeField(auto_now_add=True)
    waste_type = models.CharField(max_length=50, choices=WASTE_TYPE_CHOICES, default='other')
    municipality = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    contact = models.CharField(max_length=255)
    is_anonymous = models.BooleanField(default=False)
    is_video = models.BooleanField(default=False)
    image = models.ImageField(upload_to='complaint_images/', blank=True, null=True)

    def __str__(self):
        return f"{self.title or 'Complaint'} - {self.municipality}"
