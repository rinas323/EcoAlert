from django.db import models

class Report(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    latitude = models.FloatField()
    longitude = models.FloatField()
    timestamp = models.DateTimeField(auto_now_add=True)

class Complaint(models.Model):
    report = models.ForeignKey(Report, on_delete=models.CASCADE)
    municipality = models.CharField(max_length=255)
    status = models.CharField(max_length=50, default='pending')
    timestamp = models.DateTimeField(auto_now_add=True)