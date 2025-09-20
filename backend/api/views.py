from rest_framework import generics
from .models import Report, Complaint
from .serializers import ReportSerializer, ComplaintSerializer

class ReportListCreate(generics.ListCreateAPIView):
    queryset = Report.objects.all()
    serializer_class = ReportSerializer

class ComplaintCreate(generics.CreateAPIView):
    queryset = Complaint.objects.all()
    serializer_class = ComplaintSerializer