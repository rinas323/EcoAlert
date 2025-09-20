from django.urls import path
from .views import ReportListCreate, ComplaintCreate

urlpatterns = [
    path('reports/', ReportListCreate.as_view(), name='report-list-create'),
    path('complaints/', ComplaintCreate.as_view(), name='complaint-create'),
]
