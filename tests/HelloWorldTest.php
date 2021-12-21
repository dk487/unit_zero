<?php

declare(strict_types=1);

namespace App\Tests;

use App\HelloWorld;
use PHPUnit\Framework\TestCase;

final class HelloWorldTest extends TestCase
{
    private $hello;

    protected function setUp(): void
    {
        $this->hello = new HelloWorld();
    }

    public function testSayHello(): void
    {
        $this->expectOutputRegex('/hello/i');
        $this->hello->say();
    }

    public function testSayWorld(): void
    {
        $this->expectOutputRegex('/world/i');
        $this->hello->say();
    }
}
