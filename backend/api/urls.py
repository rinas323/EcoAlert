from django.urls import path
from .views import ComplaintCreate

urlpatterns = [
    path('complaints/', ComplaintCreate.as_view(), name='complaint-create'),
]
