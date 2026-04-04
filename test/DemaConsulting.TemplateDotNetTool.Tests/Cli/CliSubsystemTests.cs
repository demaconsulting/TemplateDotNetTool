// Copyright (c) DEMA Consulting
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

using DemaConsulting.TemplateDotNetTool.Cli;

namespace DemaConsulting.TemplateDotNetTool.Tests;

/// <summary>
///     Subsystem tests for the CLI subsystem covering Context and Program integration.
/// </summary>
[TestClass]
public class CliSubsystemTests
{
    /// <summary>
    ///     Test that Context and Program work together to handle version flag workflow.
    /// </summary>
    [TestMethod]
    public void CliSubsystem_VersionFlow_ContextAndProgram_DisplaysVersionAndExits()
    {
        // Arrange: command line arguments with version flag
        var args = new[] { "--version" };

        // Act: create context and run program logic
        using var context = Context.Create(args);
        Program.Run(context);

        // Assert: version flag is parsed and exit code is success
        Assert.IsTrue(context.Version, "Context should parse version flag");
        Assert.AreEqual(0, context.ExitCode, "Context should have success exit code");
    }

    /// <summary>
    ///     Test that Context and Program work together to handle help flag workflow.
    /// </summary>
    [TestMethod]
    public void CliSubsystem_HelpFlow_ContextAndProgram_DisplaysHelpAndExits()
    {
        // Arrange: command line arguments with help flag
        var args = new[] { "--help" };

        // Act: create context and run program logic
        using var context = Context.Create(args);
        Program.Run(context);

        // Assert: help flag is parsed and exit code is success
        Assert.IsTrue(context.Help, "Context should parse help flag");
        Assert.AreEqual(0, context.ExitCode, "Context should have success exit code");
    }

    /// <summary>
    ///     Test that Context and Program work together to handle validation flag workflow.
    /// </summary>
    [TestMethod]
    public void CliSubsystem_ValidateFlow_ContextAndProgram_RunsValidationAndExits()
    {
        // Arrange: command line arguments with validate flag
        var args = new[] { "--validate" };

        // Act: create context and run program logic
        using var context = Context.Create(args);
        Program.Run(context);

        // Assert: validate flag is parsed and exit code is success
        Assert.IsTrue(context.Validate, "Context should parse validate flag");
        Assert.AreEqual(0, context.ExitCode, "Context should have success exit code");
    }

    /// <summary>
    ///     Test that Context and Program work together to handle silent flag workflow.
    /// </summary>
    [TestMethod]
    public void CliSubsystem_SilentFlow_ContextAndProgram_SuppressesOutput()
    {
        // Arrange: command line arguments with version and silent flags
        var args = new[] { "--version", "--silent" };

        // Act: create context and run program logic
        using var context = Context.Create(args);
        Program.Run(context);

        // Assert: silent flag is parsed and exit code is success
        Assert.IsTrue(context.Silent, "Context should parse silent flag");
        Assert.AreEqual(0, context.ExitCode, "Context should have success exit code");
    }
}

