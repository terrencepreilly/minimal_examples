from django.contrib.auth import get_user_model
from django.core.urlresolvers import reverse

from rest_framework.test import APITestCase
from rest_framework import status

from ..models import Book


class BookAPITest(APITestCase):

    def setUp(self):
        self.user = get_user_model().objects.create_user(
            'test',
            'test@test.com',
            'test',
        )
        self.list_url = reverse('book-list')

    def test_unathenticated_post_fails(self):
        response = self.client.post(self.list_url, data={
            'title': 'Oryx and Crake',
        })
        self.assertEqual(
            response.status_code,
            status.HTTP_403_FORBIDDEN,
        )

    def test_post_book(self):
        self.client.force_authenticate(user=self.user)
        response = self.client.post(self.list_url, data={
            'title': 'Oryx and Crake',
        })
        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED,
        )
        self.assertEqual(
            Book.objects.first().title,
            'Oryx and Crake',
        )
