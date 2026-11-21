<?php

namespace Tests\Feature\Api\V1;

use Tests\TestCase;

class HealthTest extends TestCase
{
    /** @test */
    public function it_returns_health_status_with_valid_timestamp(): void
    {
        $response = $this->getJson('/api/v1/health');

        $response->assertStatus(200)
            ->assertJson([
                'status' => 'ok',
            ])
            ->assertJsonStructure([
                'status',
                'timestamp',
            ]);

        $timestamp = $response->json('timestamp');
        $this->assertMatchesRegularExpression(
            '/^20\d{2}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$/',
            $timestamp
        );
    }

    /** @test */
    public function it_returns_json_404_on_invalid_api_route(): void
    {
        $response = $this->getJson('/api/v1/invalid-route');

        $response->assertStatus(404)
            ->assertJson([
                'message' => 'Not Found.',
            ]);
    }
}
